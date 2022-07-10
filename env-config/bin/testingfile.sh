#!/bin/bash

# We don't want the script writes in the history
set +o history

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR
cd ../../


if [ "$#" -lt 1 ]; then
    echo "----------------------------------"
    echo "0 parameters passed to this script"
    echo "----------------------------------"
    echo "0 -> terraform apply -auto-approve"
    echo "3 -> terraform state list | grep aws_instance"
    echo "6 -> terraform state show #"
fi

if [ "$#" -eq 1 ]; then
    echo "----------------------------------"
    echo "1 parameters passed to this script"
    echo "----------------------------------"

    echo "this was the parameter passed: $1"

    # --> safe mode <--
    # command0="echo 'terraform apply -auto-approve'"
    # command3="echo 'terraform state list | grep aws_instance'"
    # command6="echo 'terraform state show #'"
    
    # fix command 3
    # Use a dictionary for this

    command0="terraform apply -auto-approve"
    command3="terraform state list | grep aws_instance"
    command6="terraform state show"

    if [ "$1" -eq 0 ]; then
        read -p "Hit enter to run: $command0"
        $command0
    fi

    if [ "$1" -eq 3 ]; then
        # fix this, it's having and error, it's due to the existence of several instances
        read -p "Hit enter to run: $command3"
        $command3
    fi

    if [ "$1" -eq 6 ]; then
        read -p "Hit enter to run: $command6"
        $command6
    fi

    phew() {
        ca3="echo 'This is not really my super long winded command'"
        # c="This is not really my super long winded command"
        read -p "Hit enter to run: $ca3"
        $ca3
    }
    phew
fi



# somefunction () {
#   echo $(echo "terraform apply -auto-approve")
# }




# phew() {
#     # c="echo 'This is not really my super long winded command'"
#     c="This is not really my super long winded command"

#     read -p "Hit enter to run: $c"
#     $c
# }
# phew













# https://opensource.com/article/18/3/creating-bash-completion-script

# _t_completions()
# {
#   COMPREPLY+=("tes1")
#   COMPREPLY+=("anotherTest1")
#   COMPREPLY+=("evenThoughtAnotherTest1")
# }
# complete -F _t_completions t

# --------------------------------------

# _t_completions()
# {
#   COMPREPLY=($(compgen -W "tes1 \nanotherTest1 \nevenThoughtAnotherTest1" "${COMP_WORDS[1]}"))
# }

# complete -F _t_completions t