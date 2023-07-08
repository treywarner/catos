#!/bin/bash

# Change directory to the desired folder containing the programs
cd /path/to/folder

# Loop through all the files in the folder
for program in *
do
    # Check if the file is executable (a program)
    if [ -x "$program" ]
    then
        # Run the program in the background
        ./"$program" &
    fi
done
# \`\`\`
# 
# Make sure to replace /path/to/folder with the actual path to the folder that contains your programs. Save the
#  script with a .sh extension, for example startup.sh.
# 
# To add the script to the startup applications:
# 
# 1. Open the Startup Applications Preferences window. You can search for "Startup Applications" in the Ubuntu Dash
#  or find it in the system settings menu.
# 2. Click on the "Add" button to add a new startup application.
# 3. In the "Name" field, enter a name for the startup item (e.g., "Run Programs").
# 4. In the "Command" field, enter the full path to the shell script you created (e.g., /path/to/startup.sh).
# 5. Optionally, you can provide a description for the startup item in the "Comment" field.
# 6. Click "Add" to save the startup item.
# 
# Now, every time you start your computer, the shell script will be executed, running all the programs in the
#  specified folder.
# 
# 
