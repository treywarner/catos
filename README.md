# Catos
Catos is a bash command that lets you use ChatGPT to affect your operating system.
It has many applications, but mostly to quickly do long tasks such as complicated renames.
In fact, I came up with this idea when I had downloaded a tutorial with long names and english numbers and wanted to shorten it and change the numbers, so it would sort better.

Use catos to
- "download the wikipedia page for bob the builder and open it with brave"
- "find all the duplicate pictures in this folder"
- "run all the programs in this folder when my computer starts in ubuntu"

## Examples
```
# output with code and commented out explanantion
catos -n "remove every file in this directory that's not a folder"

# updates code, and shows a diff of both files
catos "I also want links removed"

# reverts back, I guess I didn't actually want links removed
catos -r

# executes this
catos -x
```

## Requirements
Catos requires 
- `tgpt`
- environment variable CATOS_PATH (where you've put the program)
- environment variable CATOS_EDITOR (which editor you use)
- environment variable CATOS_DIFF (which diff you use)
Link catos to a bin folder to easily use it.

## Flags
- -n starts a new script. without this it continues your previous chat
- -l arg saves the program in your local director under the name arg
- -e opens your editor for the script
- -r reverts the changes of an ongoing chat
- -x executes the shell script
