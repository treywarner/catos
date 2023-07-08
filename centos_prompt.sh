#!/bin/bash
. $CENTOS_PATH/centos_gvars
echo "I've edited the code you provided. Here is my file: $(sed 's/`/\\\\`/g' $centos_file  | sed 's/"/\\"/g') \
\
Pay attention to the edited code and base your changes off of that rather than the original. However, I still need your help: $1. Give me the code snippet of the whole script"
