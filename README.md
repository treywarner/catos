# Cosh
Cosh is a bash command that lets you use ChatGPT to affect your operating system.
It has many applications, but mostly to quickly do long tasks such as complicated renames.
In fact, I came up with this idea when I had downloaded a tutorial with long names and english numbers and wanted to shorten it and change the numbers, so it would sort better.

## Example
```
# output with code and commented out explanantion
centos -n "remove every file in this directory that's not a folder"
# updates code, and shows a diff of both files
centos "I also want links removed"
# reverts back, I guess I didn't actually want links removed
centos -r
# executes this
centos -x
```

## Requirements
Cosh requires 
- `tgpt`
- environment variable COSH_PATH (where you've put the program)
- environment variable EDITOR (which editor you use)
Link centos to a bin folder to easily use it.

## Flags
- -n starts a new script. without this it continues your previous chat
- -l arg saves the program in your local director under the name arg
- -e opens your editor for the script
- -r reverts the changes of an ongoing chat
- -x executes the shell script
