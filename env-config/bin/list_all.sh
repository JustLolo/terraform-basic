#!/bin/bash
# parameter checking
set -u

# We don't want the script writes in the history
set +o history

# got from:
# https://stackoverflow.com/questions/59895/how-can-i-get-the-directory-where-a-bash-script-is-located-from-within-the-scrip
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd $SCRIPT_DIR


for file in $SCRIPT_DIR/*
do
  # debugging purposes
  # echo "----> Analized file = $file <------"
  if [ $file == "$SCRIPT_DIR/h.py" ] || \
     [ $file == "$SCRIPT_DIR/list_all.sh" ] || \
     [ $file == "$SCRIPT_DIR/README.md" ] || \
     [[ $file =~ $SCRIPT_DIR/commands_* ]] || \
     [[ $file =~ $SCRIPT_DIR/test* ]] || \
     [ $file == $SCRIPT_DIR/bashrc_init_script.sh ]; then
    continue
  fi
  # cat "$file"
  $file
  echo ""
done

echo "Invoke individually"
echo "t - terraform"
echo "a - aws"
echo "n - nano/edit/user/system/environment/config"
echo "g - git"