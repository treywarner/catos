#!/bin/bash

# Function to rename files and folders recursively
rename_files_and_folders() {
    for file in "$1"/*; do
        if [ -d "$file" ]; then
            # If it's a directory, recursively call the function
            rename_files_and_folders "$file"
        elif [ -f "$file" ]; then
            # If it's a file, rename it and replace occurrences in the file content
            new_file=$(echo "$file" | sed "s/centos/catos/gI")
            mv "$file" "$new_file"
            sed -i "s/centos/catos/gI" "$new_file"
        fi
    done
}

# Specify the root directory where the renaming should start
root_directory="."

# Call the function to rename files and folders
rename_files_and_folders "$root_directory"
# \`\`\`
# 
# Make sure to replace /path/to/root/directory with the actual path to the directory where you want to start
#  renaming. Please note that this script performs recursive renaming, so it will traverse through all subdirectories
#  as well.
# 
# The script uses the sed command to perform the text replacement, using the s/centos/catos/gI pattern, which
#  replaces all occurrences of "centos" with "catos" regardless of case sensitivity (g flag for global replacement
#  and I flag for case-insensitive matching).
# 
# Please exercise caution when running scripts that modify filenames and file contents. It's recommended to test the
#  script on a smaller subset of files before applying it to a large number of files or critical directories.
# 
# 
