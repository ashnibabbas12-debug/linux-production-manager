
#!/bin/bash

set -Eeuo pipefail

# Linux Production Manager
# User and Permission Management

usage() {
    echo "Usage:"
    echo "  sudo $0 create-user USERNAME"
    echo "  $0 list-users"
    echo "  sudo $0 create-group GROUP"
    echo "  sudo $0 add-to-group USERNAME GROUP"
    echo "  sudo $0 set-permissions MODE PATH"
    echo "  sudo $0 change-owner USER GROUP PATH"
}

require_root() {
    if [[ "$EUID" -ne 0 ]]; then
        echo "Error: This operation requires sudo."
        exit 1
    fi
}

valid_name() {
    [[ "$1" =~ ^[a-z_][a-z0-9_-]*$ ]]
}

case "${1:-}" in

    create-user)
        [[ $# -eq 2 ]] || { usage; exit 1; }
        require_root

        username="$2"

        if ! valid_name "$username"; then
            echo "Invalid username."
            exit 1
        fi

        if id "$username" &>/dev/null; then
            echo "User already exists: $username"
            exit 1
        fi

        useradd -m -s /bin/bash "$username"
        echo "User created successfully: $username"
        echo "Set a password separately with: sudo passwd $username"
        ;;

    list-users)
        getent passwd | awk -F: \
        '$3 >= 1000 && $3 < 60000 {
            printf "%-18s UID=%-6s HOME=%-25s SHELL=%s\n",
            $1, $3, $6, $7
        }'
        ;;

    create-group)
        [[ $# -eq 2 ]] || { usage; exit 1; }
        require_root

        group="$2"

        if ! valid_name "$group"; then
            echo "Invalid group name."
            exit 1
        fi

        if getent group "$group" >/dev/null; then
            echo "Group already exists: $group"
            exit 1
        fi

        groupadd "$group"
        echo "Group created successfully: $group"
        ;;

    add-to-group)
        [[ $# -eq 3 ]] || { usage; exit 1; }
        require_root

        username="$2"
        group="$3"

        id "$username" >/dev/null 2>&1 || {
            echo "User does not exist: $username"
            exit 1
        }

        getent group "$group" >/dev/null || {
            echo "Group does not exist: $group"
            exit 1
        }

        usermod -aG "$group" "$username"
        echo "$username added to $group"
        ;;

    set-permissions)
        [[ $# -eq 3 ]] || { usage; exit 1; }
        require_root

        mode="$2"
        target="$3"

        if [[ ! "$mode" =~ ^[0-7]{3,4}$ ]]; then
            echo "Invalid permission mode. Example: 640 or 0750"
            exit 1
        fi

        if [[ ! -e "$target" ]]; then
            echo "Path does not exist: $target"
            exit 1
        fi

        chmod "$mode" "$target"
        echo "Permissions updated: $mode $target"
        ;;

    change-owner)
        [[ $# -eq 4 ]] || { usage; exit 1; }
        require_root

        username="$2"
        group="$3"
        target="$4"

        id "$username" >/dev/null 2>&1 || {
            echo "User does not exist: $username"
            exit 1
        }

        getent group "$group" >/dev/null || {
            echo "Group does not exist: $group"
            exit 1
        }

        if [[ ! -e "$target" ]]; then
            echo "Path does not exist: $target"
            exit 1
        fi

        chown "$username:$group" "$target"
        echo "Ownership updated: $username:$group $target"
        ;;

    *)
        usage
        exit 1
        ;;
esac
