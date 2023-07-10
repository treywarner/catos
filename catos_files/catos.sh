#!/bin/bash

# Specify the folder to be backed up
source_folder="/path/to/source/folder"

# Specify the destination folder for backups
backup_folder="/path/to/backup/folder"

# Generate a timestamp for the backup file
timestamp=$(date +%Y%m%d%H%M%S)

# Create the backup file name
backup_file="${backup_folder}/backup_${timestamp}.tar.gz"

# Create the backup using tar command
tar -czf "${backup_file}" "${source_folder}"

# Check if the backup was successful
if [ $? -eq 0 ]; then
    echo "Backup created successfully: ${backup_file}"
else
    echo "Backup failed!"
fi
#
# Explanation ----------------- 
# 
# To use this script, follow these steps:
# 
# 1. Replace /path/to/source/folder with the actual path to the folder you want to back up.
# 2. Replace /path/to/backup/folder with the actual path to the folder where you want to store the backups.
# 
# Save the script to a file, let's say backup.sh, and make it executable by running chmod +x backup.sh in the terminal.
# 
# To schedule the backup to run every day, you can use the cron utility. Open the crontab file by running crontab -e and add the following line:
# 
#
# Explanation ----------------- 
# 0 0 * * * /path/to/backup.sh >/dev/null 2>&1
#
# Explanation ----------------- 
# 
# This will execute the script at midnight (00:00) every day. Make sure to replace /path/to/backup.sh with the actual path to the script.
# 
