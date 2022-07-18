# Folder for environment configuration commands.
Just to make mine/your life easier

## allow the user to run sudo withtout asking for a password
-> Run the following command
sudo visudo

-> Add the following to the bottom of the file and substitute 'username'
-> for your own linux username
augartep92     ALL=(ALL) NOPASSWD:ALL

## history template for most used commands

### copy .bash_history_template in $HOME aka ~/
### command:
copy .bash_history_template ~/

## ultimate history hack
### copy the info contained in inputrc to /etc/inputrc
### command:
cat .inputrc >> ~/.inputrc

### Usage
!history_number + space and you'll get the command without execution

## adding info to path
### Needed for the personal scripts (./bin) I'll be using every day
// added at the end
PATH=$PATH:~/bin

// added at the beginnig
PATH=~/bin:$PATH

## packages needed
sudo apt install graphviz
