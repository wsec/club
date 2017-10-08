#!/bin/bash 

#written by Jennings Zhang, May 2017  
#This script will make the cygwin linux terminal emulation program on school computers less frustrating to use. 
#Usage: ./bad-cygwin.sh [NEW_HOME_DIR]
#WARNING: this script was kinda inflexible... This software is provided AS IS, don't blame me for any catastrophies or vomitting.
#version 0.4

#Features overview: 
#launch notepad++ from cygwin simply by typing "npp &".
#instantly create a new hello world C file by typing "createc".
#"ls" is colorful.
#your home directory (the default directory cygwin opens in) will be changed to H:\cygwin_home. This folder is accessible with Windows file explorer, making your life much easier. 
#Repeated commands are not repeated in your history.
#If a job exits with a non-zero return status, the return status is displayed at the end of the first line of the prompt in red.

TODAY=$(date "+%m/%d/%Y")
echo "Today is $TODAY"
echo "This script will make cygwin on a school computer less frustrating to use. Written by Jennings Zhang, last updated October 2017."

if [[ "$1" = *-h* ]]; then
  
  echo "Usage: ./bad-cygwin.sh [NEW_HOME_DIR]"
  exit 0
fi

cd ~

cp -v .bash_profile .bash_profile.backup

new_home="/cygdrive/h/cygwin_home"
new_home_esc="\/cygdrive\/h\/cygwin_home\/"

#in case a specific new home directory was specified by $1
if [ -n "$1" ]; then
  $new_home=$1
  new_home_esc=$(echo $new_home | sed 's/\//\\\//g')
fi

mkdir $new_home
sed -i "1iexport HOME=$new_home_esc\ncd ~" .bash_profile

echo "Your new home (~) directory is: $new_home. Cygwin will now open in this directory by default." 

ARRAY=(.bashrc .inputrc .profile)

cp -vi ${ARRAY[*]} $new_home

echo "Copied ${ARRAY[*]} into $new_home."
cd $new_home

#append scripts to .bashrc
#retrive gentoo-bashrc from Github repository
#also add some useful functions and aliases
cat >> .bashrc << EOF

#<<<<<<< BEGIN added by bad-cygwin.sh on $TODAY

#This is the bashrc file from gentoo linux.
$(curl https://raw.githubusercontent.com/jennydaman/twlinux/master/student_resources/gentoo-bashrc)

#add return status before bash prompt
PS1='$(EXIT="$?"; [ "$EXIT" -ne "0" ] && echo "\[\e[31;1m\]$EXIT|")'$PS1

#Here are the customizations specific to cygwin use in prog 3:

alias npp="/cygdrive/c/Program\ Files\ \(x86\)/npp/notepad++.exe"

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

#>>>>>>> END added by bad-cygwin.sh
EOF

cat >> .virc << EOF
set number
syntax on
set cursorline
hi CursorLine term=bold cterm=bold 
EOF

#clean up, clean up, everybody everywhere
unset TODAY new_home new_home_esc ARRAY

echo "Some lines were added to the $(tput bold)~/.bashrc$(tput sgr0) configuration file."
echo "I've made some quality of life changes."
echo 'createc [FILENAME] will write "Hello World" out to the specified file.'
echo '$(tput bold)npp [FILENAME] &$(tput sgr0) will launch notepad++ directly from cygwin.'

echo "Done! Please $(tput bold)restart cygwin$(tput sgr0) to finish applying the changes. "
echo "If you want to revert these changes, delete the cygwin_home folder, then: cd /home/\$USER && mv .bash_profile.backup .bash_profile"
echo "DFTBA"
