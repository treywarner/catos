#!/bin/bash

# Remove files in the 'saves' folder
rm -r saves/*

# Remove files in the 'files' folder
rm -r files/*

# Commit and push changes to Git repository
git add .
git commit -m "$1"
git push
#
# Explanation ----------------- 
# 
# Save the above code into a file, for example, cleanup_and_push.sh. Make sure to give execute permission to the file using the command chmod +x cleanup_and_push.sh. Then you can run the script using ./cleanup_and_push.sh in the terminal.
# 
