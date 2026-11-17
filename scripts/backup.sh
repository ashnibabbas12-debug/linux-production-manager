
#!/bin/bash

# ==========================================
# LINUX PRODUCTION MANAGER
# AUTOMATED BACKUP & RESTORE
# ==========================================

set -Eeuo pipefail

PROJECT_DIR="$HOME/linux-production-manager"
BACKUP_DIR="$PROJECT_DIR/backups/daily"
RESTORE_DIR="$PROJECT_DIR/backups/restore-preview"

mkdir -p "$BACKUP_DIR"

# Create a timestamp for unique backup names
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/linux-prod-$TIMESTAMP.tar.gz"

# ---------------- CREATE BACKUP ----------------

create_backup() {
    echo "Starting application backup..."

    tar -czf "$BACKUP_FILE" \
        -C "$PROJECT_DIR" app config

    echo "Backup created successfully!"
    echo "Backup file: $BACKUP_FILE"
    echo "Backup size:"
    du -h "$BACKUP_FILE"
}

# ---------------- LIST BACKUPS ----------------

list_backups() {
    echo "Available backups:"
    find "$BACKUP_DIR" -maxdepth 1 -type f \
        -name 'linux-prod-*.tar.gz' -printf '%f\n' | sort
}

# ---------------- RESTORE BACKUP ----------------

restore_backup() {
    local archive="${1:-}"

    if [ -z "$archive" ] || [ ! -f "$archive" ]; then
        echo "Usage: $0 restore /path/to/backup.tar.gz"
        return 1
    fi

    # Confirm that the archive is readable
    if ! tar -tzf "$archive" >/dev/null; then
        echo "ERROR: Invalid or damaged backup archive."
        return 1
    fi

    local destination="$RESTORE_DIR/restore-$TIMESTAMP"
    mkdir -p "$destination"

    tar -xzf "$archive" -C "$destination"

    echo "Backup extracted successfully."
    echo "Preview location: $destination"
    echo "Original application files were NOT overwritten."
}

# ---------------- RETENTION CLEANUP ----------------

prune_backups() {
    echo "Backups older than 7 days:"
    find "$BACKUP_DIR" -maxdepth 1 -type f \
        -name 'linux-prod-*.tar.gz' -mtime +7 -print

    echo
    read -r -p "Delete these old backup archives? (yes/no): " answer

    if [ "$answer" = "yes" ]; then
        find "$BACKUP_DIR" -maxdepth 1 -type f \
            -name 'linux-prod-*.tar.gz' -mtime +7 -delete
        echo "Old backup archives deleted."
    else
        echo "Cleanup cancelled."
    fi
}

# ---------------- MAIN MENU ----------------

case "${1:-create}" in
    create)
        create_backup
        ;;
    list)
        list_backups
        ;;
    restore)
        restore_backup "${2:-}"
        ;;
    prune)
        prune_backups
        ;;
    *)
        echo "Usage:"
        echo "$0 create"
        echo "$0 list"
        echo "$0 restore /path/to/backup.tar.gz"
        echo "$0 prune"
        exit 1
        ;;
esac
