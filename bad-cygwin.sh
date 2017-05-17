#!/bin/bash 

#This script will make cygwin on the school computers less frustrating to use. 
#WARNING: this script is very inflexible... 
#version 0.1
#written by Jennings Zhang, May 2017 #aiden 

date
echo "This script will make cygwin on a school computer less frustrating to use. Written by Jennings Zhang, May 2017."

cd ~

cp -v .bash_profile .bash_profile.backup

new_home="/cygdrive/h/cygwin_home"

mkdir $new_home
sed -i "1iexport HOME=\/cygdrive\/h\/cygwin_home\/\ncd ~" .bash_profile
#regex=""
#new_home="export HOME=\/cygdrive\/c\/cygwin_home\/\ncd ~"
#sed  "/$regex/ { N; s/$regex\n/$new_home\n&/ }" .bash_profile > buffer && mv -f buffer .bash_profile
echo "Your new home (~) directory is: $new_home. Cygwin will now open in this directory by default." 

cp -v .bashrc .inputrc .profile $new_home
cd $new_home

cat >> .bashrc << EOF
#>>>>begin added by bad-cygwin.sh on $(date "+%m/%d/%Y")
alias ls="ls --color=auto"
alias grep="grep --color"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100
HISTFILESIZE=2000
alias npp="/cygdrive/c/Program\ Files\ \(x86\)/npp/notepad++.exe"
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w$(EXIT="$?"; [ "$EXIT" -ne "0" ] && echo "\[\e[31;1m\] | $EXIT")\[\e[0m\]\n\$ '
#<<<<end added by bad-cygwin.sh
EOF

cat >> .virc << EOF
set backspace=indent,eol,start
set number
syntax on
set cursorline
hi CursorLine term=bold cterm=bold 
EOF

echo "Some lines were added to the ~/.bashrc configuration file."
echo 'You can launch notepad++ directly from cygqin by typing "npp [FILENAME]".'
echo "Tip: appending '&' to a command runs the command in the background."
echo "So, 'npp &' will launch notepad++ without keeping your shell busy, so you can keep using your shell and notepad++ at the same time."
echo "A .virc file was also created."
echo "Done! Please restart cygwin to fully apply the changes. "
echo "If you want to revert these changes, delete the cygwin_home folder, and also remove the first two lines of /users/\$USER/.bash_profile."

