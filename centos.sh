#!/bin/bash

. $CENTOS_PATH/centos_gvars
prompter="centos_prompt.sh"
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
		cat $CENTOS_PATH/temp/$centos_fname > $centos_file
		exit
		;;
    	x)
		. $centos_file
		exit
		;;
    	e)
		$CENTOS_EDITOR $centos_file
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
	file=$CENTOS_PATH/centos_files/centos.sh
	fname=centos.sh
	if [[ $LOCAL == 1 ]]
	then
		file="$(pwd)/$FNAME"
		fname=$FNAME
	fi
      	tgpt -f
      	prompter="centos_new_prompt.sh"
	echo "centos_file=$file" > $CENTOS_PATH/centos_gvars
	printf "centos_fname=$fname" >> $CENTOS_PATH/centos_gvars
      	touch $CENTOS_PATH/temp/$fname
	touch $file
fi


. $CENTOS_PATH/centos_gvars
input_file=$CENTOS_PATH/temp/$centos_fname

if [[ $1 == "" ]]
then
	echo "Error: no prompt"
	exit 1
fi
echo "" > $input_file


script -q -c "tgpt \"$($CENTOS_PATH/$prompter "$1")\"" $input_file
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
	cat $input_file > $centos_file
	chmod +x $centos_file
else
	cat $centos_file > $CENTOS_PATH/swap_tmp
	cat $input_file > $centos_file
	cat $CENTOS_PATH/swap_tmp > $input_file

	read -p "Press enter to see diff"

	$CENTOS_DIFF -u $input_file $centos_file | colordiff
fi
