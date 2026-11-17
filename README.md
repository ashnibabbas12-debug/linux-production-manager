# Linux Production Manager

A Bash-based Linux system administration and automation project designed to simplify common production server management tasks.

This project demonstrates practical Linux skills through automation scripts for system monitoring, log analysis, backup management, user administration, service management, and system cleanup.

The goal is to build a simple toolkit that helps Linux administrators monitor system health, manage files and logs, automate routine operations, and maintain a more organized server environment.

## Project Objectives

- Automate repetitive Linux administration tasks.
- Monitor system health and resource utilization.
- Analyze application logs and generate reports.
- Create and manage compressed backups.
- Practice Linux user and permission management.
- Manage system services and inspect system logs.
- Improve Bash scripting and error handling.
- Use Git and GitHub for version control.

## Technologies Used

| Technology | Purpose |
|---|---|
| Ubuntu Linux | Operating system |
| Bash Shell | Automation scripting |
| Linux Commands | System administration |
| systemctl | Service management |
| journalctl | System log inspection |
| tar and gzip | Backup and compression |
| Git | Version control |
| GitHub | Project hosting |

## Project Structure

```text
linux-production-manager/
│
├── app/
│   ├── app.log
│   ├── application.conf
│   └── application.bak
│
├── backups/
│   ├── daily/
│   └── weekly/
│
├── config/
│   └── manager.conf
│
├── logs/
│   ├── error.log
│   ├── monitoring.log
│   └── system.log
│
├── reports/
│   ├── error-report.txt
│   ├── log-summary.txt
│   └── system-report.txt
│
└── scripts/
    ├── backup.sh
    ├── cleanup.sh
    ├── health-check.sh
    ├── log-analyzer.sh
    ├── system-info.sh
    └── user-manager.sh
```

## Key Features

### 1. System Health Monitoring

Collects important system information, including:

- Hostname and operating system details.
- Kernel information.
- System uptime and load.
- CPU information.
- Memory utilization.
- Disk utilization.
- Running processes.
- Network information.

Generates a system health report inside the `reports/` directory.

### 2. Automated Log Analysis

Analyzes application logs and identifies:

- ERROR messages.
- WARNING messages.
- INFO messages.

Generates reports containing log counts and summaries to make troubleshooting easier.

### 3. Automated Backup Management

Uses Bash scripting and Linux archive utilities to:

- Create compressed backups.
- Store backups in organized directories.
- Archive application and configuration files.
- Support backup restoration and management.

Backup archives use the `.tar.gz` format.

### 4. User and Permission Management

Practices Linux account and access management, including:

- User creation.
- Group management.
- File ownership.
- File permissions.
- User and group verification.

### 5. Service Management

Uses Linux service management commands to:

- Check service status.
- Start and stop services.
- Restart services.
- Enable and disable services.
- Inspect service logs.

### 6. System Cleanup

Includes automation for routine cleanup and disk-space management tasks.

## Getting Started

### Prerequisites

- Ubuntu Linux or another compatible Linux distribution.
- Bash shell.
- Git.
- Basic Linux command-line knowledge.

### 1. Clone the Repository

```bash
git clone git@github.com:ashnibabbas12-debug/linux-production-manager.git
```

### 2. Navigate to the Project

```bash
cd linux-production-manager
```

### 3. Make Scripts Executable

```bash
chmod u+x scripts/*.sh
```

### 4. Run System Information Script

```bash
./scripts/system-info.sh
```

### 5. Run System Health Check

```bash
./scripts/health-check.sh
```

### 6. Run Log Analyzer

```bash
./scripts/log-analyzer.sh
```

### 7. Create a Backup

```bash
./scripts/backup.sh create
```

Check the generated backup:

```bash
ls -lh backups/daily/
```

**Note:** Review each script before running it, especially scripts that modify users, permissions, services, or system files. Some operations may require sudo privileges.

## Learning Outcomes

Through this project, I am developing practical experience with:

- Linux filesystem management.
- File and directory operations.
- Linux users, groups, and permissions.
- Process and service management.
- Bash scripting and automation.
- Log analysis and troubleshooting.
- Backup and recovery fundamentals.
- Disk-space management.
- Git and GitHub workflows.
- Working with an Ubuntu EC2 Linux environment.

## Future Improvements

Planned improvements include:

- Better script error handling.
- Centralized logging.
- Automated backup scheduling using cron.
- Backup retention and cleanup policies.
- More detailed system health reports.
- Improved documentation and testing.
- Integration with monitoring tools.

## Author

**Ashnab Abbas**

Cloud & DevOps Engineer | Linux | AWS | Docker | CI/CD

GitHub: [ashnibabbas12-debug](https://github.com/ashnibabbas12-debug)

---

*This is a hands-on learning project focused on practical Linux system administration, Bash automation, and DevOps fundamentals.*
