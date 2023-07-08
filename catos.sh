#!/bin/bash

. $CATOS_PATH/catos_gvars
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
		cat $CATOS_PATH/temp/$catos_fname > $catos_file
		exit
		;;
    	x)
		. $catos_file
		exit
		;;
    	e)
		$catos_EDITOR $catos_file
		exit
		;;
    	?)
      		echo "script usage: $(basename \$0) [-n] [-l arg] [r] [x] [e]" >&2
      		exit 1
      		;;
  	esac
done
shift $((OPTIND-1))

if [[ $FIRST == 1 ]]
then
	file=$CATOS_PATH/catos_files/catos.sh
	fname=catos.sh
	if [[ $LOCAL == 1 ]]
	then
		file="$(pwd)/$FNAME"
		fname=$FNAME
	fi
      	tgpt -f
      	prompter="catos_new_prompt.sh"
	echo "catos_file=$file" > $CATOS_PATH/catos_gvars
	printf "catos_fname=$fname" >> $CATOS_PATH/catos_gvars
      	touch $CATOS_PATH/temp/$fname
	touch $file
fi


. $CATOS_PATH/catos_gvars
input_file=$CATOS_PATH/temp/$catos_fname

if [[ $1 == "" ]]
then
	echo "Error: no prompt"
	exit 1
fi
echo "" > $input_file


script -q -c "tgpt \"$($CATOS_PATH/$prompter "$1")\"" $input_file
sed -i "s|||g" $input_file
sed -i -E "s/\x1B\[[0-9;]*[a-zA-Z]//g" $input_file

cat $input_file > testb

first_backtick_line_number=$(grep -n '```' <<< "$(cat $input_file)" | head -n 1 | cut -d ':' -f 1)

# Remove lines before the specified line number
echo "$(tail -n +"$(($first_backtick_line_number + 1))" $input_file)" > $input_file

first_backtick_line_number=$(grep -n '```' <<< "$(cat $input_file)" | head -n 1 | cut -d ':' -f 1)

sed -i "${first_backtick_line_number},\$s/^/# /" $input_file
sed -i 's/`/\\`/g' $input_file
sed -i '$ d' $input_file

if [[ $FIRST == 1 ]]
then
	cat $input_file > $catos_file
	chmod +x $catos_file
else
	cat $catos_file > $CATOS_PATH/swap_tmp
	cat $input_file > $catos_file
	cat $CATOS_PATH/swap_tmp > $input_file

	read -p "Press enter to see diff"

	$catos_DIFF -u $input_file $catos_file | colordiff
fi
