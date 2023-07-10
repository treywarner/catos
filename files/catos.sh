#!/bin/bash

# Define the source and destination directories
source_dir="."
backup_dir="~/backups"

# Create a timestamp for the backup file name
timestamp=$(date +"%Y%m%d%H%M%S")

# Compose the backup file name with timestamp
backup_file="${backup_dir}/backup_${timestamp}.tar.gz"
# Create the backup using tar command
tar -czf "$backup_file" "$source_dir"

# Check if the backup was created successfully
if [ $? -eq 0 ]; then
    echo "Backup created successfully at ${backup_file}"
else
    echo "Backup creation failed."
fi
#
# Explanation ----------------- 
# 
# In this version, the source_dir is set to ".", which represents the current directory, and backup_dir is set to "~/backups", which represents the backups folder in the user's home directory.
# 
