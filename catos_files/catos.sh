#!/bin/bash

# Function to capture the output of the other command
capture_output() {
    while read -r line; do
        if [[ $line == *"$target_substring"* ]]; then
            echo "$line"
            break
        fi
    done
}

# Command to launch the other script and redirect its output to the function
/path/to/other_script.sh | capture_output
# 
# 
# Replace /path/to/other_script.sh with the actual path to the script you want to launch. The target_substring
#  variable should be set to the specific substring that you want to wait for before printing any output.
# 
# Here's how the script works:
# 1. It defines a function named capture_output which reads the input line by line.
# 2. In each iteration, it checks if the current line contains the target_substring using the *"$target_substring
# "* pattern matching.
# 3. If the target_substring is found in a line, it echoes that line and breaks the loop.
# 4. The script launches the other script and pipes its output to the capture_output function, effectively
#  capturing the output.
# 5. The script will wait until the target_substring is encountered in the output, and then print that line and
#  exit.
# 
# Please replace /path/to/other_script.sh with the correct path and modify the target_substring according to your
#  requirements.
# 
# 
