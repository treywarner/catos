#!/bin/bash

# Command to launch the other script
./path/to/other_script.sh > /path/to/other_script_output.log &

# String to wait for
target_string="Specific String"

# Loop until the target string is found
while :
do
    # Check if the target string is present in the output file
    if grep -q "$target_string" /path/to/other_script_output.log
    then
        break
    fi
    
    # Sleep for a short duration before checking again
    sleep 1
done

# Find the line number where the target string appears
line_number=$(grep -n "$target_string" /path/to/other_script_output.log | cut -d : -f 1)

# Display the output from the target string onwards
tail -n +$line_number -f /path/to/other_script_output.log
# 
# 
# Replace ./path/to/other_script.sh with the actual path to the script you want to launch, and /path/to/other
# _script_output.log with the path to the log file where the output of the other script is redirected.
# 
# Here's how the updated script works:
# 1. It launches the other script in the background using > /path/to/other_script_output.log to redirect its output
#  to a log file.
# 2. It enters a loop and checks the output file (e.g., other_script_output.log) for the presence of the target
#  string using grep.
# 3. If the target string is found, the loop breaks.
# 4. Once the target string is found, it uses grep -n to find the line number where the target string appears.
# 5. Finally, it displays the output from the target string onwards using tail -n +$line_number -f.
# 
# Please make sure to adjust the paths in the script according to your specific file locations.
# 
# 
