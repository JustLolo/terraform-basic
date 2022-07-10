#!/bin/bash -i

# checking parameters, modified, setting this will give me some problems checking 'e'
# set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
cd ../../
file="./env-config/bin/commands_terraform"

# try to load part of the environment using -> !/bin/bash -i 
# this is nothing #!/usr/bin/env bash
# --rcfile file
# because I can chain commands

# filling the dictionary
declare -A command
# -n "$line" -> added due to the issue that doesn't show the last line
while IFS= read -r line || [ -n "$line" ]; do
    commandKey="$(echo "$line" | cut -d " " -f 1)"
    commandValue="$(echo "$line" | cut -d " " -f2-)"
    command[$commandKey]=$commandValue
done < "$file"

if [ "$#" -lt 1 ]; then
    echo "REMEMBER: -e for execution without user confirmation"
    echo "REMEMBER: You can add parameters or pipelines"
    echo ""
    for key in "${!command[@]}"
        do echo "$key - ${command[$key]}"
    done
fi

if [ "$#" -eq 1 ]; then
    echo "----------------------------------"
    echo "1 parameters passed to this script"
    echo "----------------------------------"

    read -p "Enter to run -> ${command[$1]} " parameter
    eval ${command[$1]} $parameter
fi

if [[ "$#" -eq 2 ]]; then
    if [[ "$2" -eq "-e" ]]; then
        # "e" stands for execute without confirmation
        echo "${command[$1]} --> executing"
        echo ""
        eval ${command[$1]}
    fi
fi