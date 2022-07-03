#Configuring AWS access
export AWS_ACCESS_KEY_ID=EXAMPLE_AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=EXAMPLE_AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=EXAMPLE_AWS_DEFAULT_REGION
eval "$(ssh-agent -s)"
eval "$(ssh-add ~/.ssh/id_ed25519)"

# Setting up History behavior
# Template added at the end of history for easy access to frequently used commands
cat ~/.bash_history_template >> ~/.bash_history
cp  ~/.bash_history ~/.bash_history_temporal
# deleting the begining template and leaving only the one at the end
tac ~/.bash_history_temporal | awk '!seen[$0]++' | tac > ~/.bash_history
rm ~/.bash_history_temporal
export HISTCONTROL=ignoredups
