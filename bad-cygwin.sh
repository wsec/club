#!/bin/bash 

#This script will make cygwin on the school computers less frustrating to use. 
#Usage: ./bad-cygwin.sh [NEW_HOME_DIR]
#WARNING: this script was kinda inflexible... 
#version 0.3
#written by Jennings Zhang, May 2017  

#Features overview: 
#launch notepad++ from cygwin simply by typing "npp &".
#instantly create a new hello world C file by typing "createc".
#"ls" is colorful.
#your home directory (the default directory cygwin opens in) will be changed to H:\cygwin_home. This folder is accessible with Windows file explorer, making your life much easier. 
#Repeated commands are not repeated in your history.
#If a job exits with a non-zero return status, the return status is displayed at the end of the first line of the prompt in red.

TODAY=$(date "+%m/%d/%Y")
echo "Today is $TODAY"
echo "This script will make cygwin on a school computer less frustrating to use. Written by Jennings Zhang, May 2017."

if [[ "$1" = *-h* ]]; then
  
  echo "Usage: ./bad-cygwin.sh [NEW_HOME_DIR]"
  exit 0
fi


cd ~

cp -v .bash_profile .bash_profile.backup

new_home="/cygdrive/h/cygwin_home"
new_home_esc="\/cygdrive\/h\/cygwin_home\/"

if [ -n "$1" ]; then
  $new_home=$1
  new_home_esc=$(echo $new_home | sed 's/\//\\\//g')
fi

mkdir $new_home
sed -i "1iexport HOME=$new_home_esc\ncd ~" .bash_profile
#regex=""
#new_home="export HOME=\/cygdrive\/c\/cygwin_home\/\ncd ~"
#sed  "/$regex/ { N; s/$regex\n/$new_home\n&/ }" .bash_profile > buffer && mv -f buffer .bash_profile
echo "Your new home (~) directory is: $new_home. Cygwin will now open in this directory by default." 

cp -vi .bashrc .inputrc .profile $new_home
cd $new_home

cat >> .bashrc << EOF
#>>>>BEGIN added by bad-cygwin.sh on $TODAY
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

createc() {
  local file_name=hello_world.c
  [ -n "$1" ] && file_name=$1
  cat > $file_name << ENDOFHELLOWORLD
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char *argv[]) {

	printf("Hello world!");
	return 0;
}
ENDOFHELLOWORLD
}
#<<<<END added by bad-cygwin.sh
EOF

cat >> .virc << EOF
set backspace=indent,eol,start
set number
syntax on
set cursorline
hi CursorLine term=bold cterm=bold 
EOF

echo "Some lines were added to the ~/.bashrc configuration file."
echo "I've made some quality of life changes."
echo 'createc [FILENAME] will write "Hello World" out to the specified file.'
echo 'npp [FILENAME] & will launch notepad++ directly from cygwin.'
echo 'Tip: "&" will make a job run in the background. If you launch notepad++ without the "&", then it will keep your shell busy."

echo "Done! Please restart cygwin to fully apply the changes. "
echo "If you want to revert these changes, delete the cygwin_home folder, then: cd /home/\$USER && mv .bash_profile.backup .bash_profile"
echo "DFTBA"
