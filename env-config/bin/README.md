# Folder of useful commands you/I will use always
# # Run these commands in this same actual folder
<!-- ln -s $(pwd) ~/bin -->
<!-- export PATH=$PATH:$(pwd) -->
echo export PATH='$PATH':$(pwd) >> ~/.bashrc
echo 'echo "---> press h key for help/tips" <---' >> ~/.bashrc
chmod +x *

echo 'alias h="h.py"' >> ~/.bash_aliases
echo 'alias t="terraform_info.sh"' >> ~/.bash_aliases
echo 'alias a="aws_info.sh"' >> ~/.bash_aliases
echo 'alias n="environment_config.sh"' >> ~/.bash_aliases
echo 'alias g="git_info.sh"' >> ~/.bash_aliases


# # # Below is explained what they are doing

<!-- # # Create a soft link to this folder in $HOME folder
ln -s $(pwd) ~/bin

# # # If ~/bin already exist, try to figure it by yourself how to solve it :(
# # # this wasn't my case, my ~/bin folder was empty, I just deleted it and
# # # and created the soft link -->

# # adding this folder to path
# # # Needed for the personal scripts (./bin) I'll be using every day
# # # add this to ~/.bashrc if you'll use it always
# # # # added at the end of PATH
echo export PATH='$PATH':$(pwd) >> ~/.bashrc

# # # # added at the beginnig of PATH
echo export PATH=$(pwd):'$PATH' >> ~/.bashrc

# # We want to be able to execute every one of the scripts in this folder
chmod +x *
