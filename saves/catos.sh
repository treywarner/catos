#!/bin/bash

# Define the source and destination directories
source_dir="/path/to/source/folder"
backup_dir="/path/to/backup/folder"

# Create a timestamp for the backup file name
timestamp=$(date +"%Y%m%d%H%M%S")

# Compose the backup file name with timestamp
backup_file="${backup_dir}/backup_${timestamp}.tar.gz"

# Create the backup using tar command
tar -czf "${backup_file}" "${source_dir}"

# Check if the backup was created successfully
if [ $? -eq 0 ]; then
    echo "Backup created successfully at ${backup_file}"
else
    echo "Backup creation failed."
fi
#
# Explanation ----------------- 
# 
# Make sure to replace "/path/to/source/folder" with the actual path of the folder you want to back up, and "/path/to/backup/folder" with the desired backup directory.
# 
# Save the above script in a file, e.g., backup.sh, and make it executable using the command chmod +x backup.sh. Then simply run the script using ./backup.sh in your terminal.
# 
