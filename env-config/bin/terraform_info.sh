#!/bin/bash -i
# checking parameters
set -u

# -----> TODO <--------------
# fix command 3             |
# Use a dictionary for this |
# ---------------------------

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
cd ../../

declare -A command=( [0]="terraform state show"\
                     [1]="terraform state list | grep aws_instance"\
                     [2]="terraform apply -auto-approve")
                     

if [ "$#" -lt 1 ]; then
    echo "----------------------------------"
    echo "0 parameters passed to this script"
    echo "----------------------------------"
    echo "REMEMBER: You can add a parameters o pipelines"
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