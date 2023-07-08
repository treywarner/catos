#!/bin/bash

# GLOBAL VARS

if [[ -z "$CATOS_PATH" ]]; then
	echo "Fatal error: CATOS_PATH must be set."
	exit 1	
fi
if [[ -z "$CATOS_EDITOR" ]]; then
	if [[ -z "$EDITORR" ]]; then
		export CATOS_EDITOR=$EDITOR
	else
		export CATOS_EDITOR=vim
	fi
    	echo "Environment variable CATOS_EDITOR set to: $CATOS_EDITOR"
fi
if [[ -z "$CATOS_DIFF" ]]; then
	export CATOS_DIFF=vimdiff
    	echo "Environment variable CATOS_DIFF set to: $CATOS_DIFF"
fi
. $CATOS_PATH/catos_gvars



#CLEAN_UP

# Function to be executed on Ctrl+C
cleanup() {
    echo "Shutting down..."
    cat $catos_sfile > $catos_file
    exit 0
}

# Register the cleanup function to execute on SIGINT signal
trap cleanup SIGINT


prompter="catos_prompt.sh"
export FIRST=0
export LOCAL=0
export FNAME=0
while getopts 'l:rxne' OPTION; do
	case "$OPTION" in
	l)
		export LOCAL=1
	      	export FNAME=${OPTARG}
		;;
	n)
      		export FIRST=1
		;;
    	r)
		cat $catos_sfile > $catos_file
		exit
		;;
    	x)
		. $catos_file
		exit
		;;
    	e)
		$CATOS_EDITOR $catos_file
		exit
		;;
    	?)
      		echo "script usage: $(basename \$0) [-n] [-l arg] [r] [x] [e]" >&2
      		exit 1
      		;;
  	esac
done
shift $((OPTIND-1))

# CREATING NEW CHAT

if [[ $FIRST == 1 ]]
then
	file=$CATOS_PATH/catos_files/catos.sh
	sfile=$CATOS_PATH/catos_saves/catos.sh
	if [[ $LOCAL == 1 ]]
	then
		file="$(pwd)/$FNAME"
		sfile=$CATOS_PATH/catos_saves/$FNAME
	fi
      	tgpt -f
      	prompter="catos_new_prompt.sh"
	echo "catos_file=$file" > $CATOS_PATH/catos_gvars
	printf "catos_sfile=$sfile" >> $CATOS_PATH/catos_gvars
      	touch $sfile $file
	chmod +x $file $sfile
fi

#reload variables
. $CATOS_PATH/catos_gvars

if [[ $1 == "" ]]
then
	echo "Error: no prompt"
	exit 1
fi

cat $catos_file > $catos_sfile
echo "" > $catos_file	


script -q -c "tgpt \"$($CATOS_PATH/$prompter "$1")\"" $catos_file
sed -i "s|||g" $catos_file
sed -i -E "s/\x1B\[[0-9;]*[a-zA-Z]//g" $catos_file


first_backtick_line_number=$(grep -n '```' <<< "$(cat $catos_file)" | head -n 1 | cut -d ':' -f 1)

# Remove lines before the specified line number
echo "$(tail -n +"$(($first_backtick_line_number + 1))" $catos_file)" > $catos_file

first_backtick_line_number=$(grep -n '```' <<< "$(cat $catos_file)" | head -n 1 | cut -d ':' -f 1)

sed -i "${first_backtick_line_number},\$s/^/# /" $catos_file
sed -i 's/`//g' $catos_file
sed -i '$ d' $catos_file

if [[ $FIRST == 1 ]]
then
	exit
else

	read -p "Press enter to see diff"

	$CATOS_DIFF $catos_file $catos_sfile | colordiff
fi
