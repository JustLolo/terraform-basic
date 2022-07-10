#!/bin/bash -i

# We don't want the script writes in the history
set +o history

# checking parameters, modified, setting this will give me some problems checking 'e'
# set -u
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
cd ../../
file="./env-config/bin/frequently_used_terraform_commands"

# TODO
# fill the frequently_used_terraform_commands file where the first line will be the key/index
# Finish this thing above, I have to save the read lines in the dictionary 'command'
#                |
#                |
#                V
# -n "$line" -> added due to the issue that doesn't show the last line
# while IFS= read -r line || [ -n "$line" ]; do
#     echo "$line"
# done < "$file"




declare -A command=( [0]="terraform state show"\
                     [1]="terraform state list | grep aws_instance"\
                     [2]="terraform apply -auto-approve")
                     

if [ "$#" -lt 1 ]; then
    echo "----------------------------------"
    echo "0 parameters passed to this script"
    echo "----------------------------------"
    echo "REMEMBER: You can add a parameters o pipelines"
    file="./env-config/bin/frequently_used_terraform_commands"

    for key in "${!command[@]}"
        do echo "$key - ${command[$key]}"
    done


    # echo "0 -> terraform apply -auto-approve"
    # echo "3 -> terraform state list | grep aws_instance"
    # echo "6 -> terraform state show #"
fi

if [ "$#" -eq 1 ]; then
    echo "----------------------------------"
    echo "1 parameters passed to this script"
    echo "----------------------------------"

    # --> safe mode <--
    # command0="echo 'terraform apply -auto-approve'"
    # command3="echo 'terraform state list | grep aws_instance'"
    # command6="echo 'terraform state show #'"
    read -p "Enter to run -> ${command[$1]} " parameter
    eval ${command[$1]} $parameter
fi