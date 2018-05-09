#!/bin/bash -e

# written by Jennings Zhang, updated for May 2018
# Usage: ./bad-cygwin.sh [NEW_HOME_DIR]
# This software is provided AS IS, don't blame me for any catastrophies or vomitting.
# soruce: https://github.com/twlinux/club/blob/master/student_resources/bad-cygwin.sh

# This script will configure cygwin on school computers.
# Targets ONLY Windows 10 computers in technology labs at wootton. Don't use this anywhere else.

today=$(date "+%m/%d/%Y")
echo "Last updated: 50/09/2018. Today is $today"

if [[ "$1" = *-h* ]]; then
  echo "Usage: ./bad-cygwin.sh [NEW_HOME_DIR]"
  exit 0
fi

cd ~

cp -v .bash_profile .bash_profile.backup

new_home="/cygdrive/h/cygwin_home"
new_home_esc="\/cygdrive\/h\/cygwin_home\/"

# in case a specific new home directory was specified by $1
if [ -n "$1" ]; then
  new_home=$1
  new_home_esc=$(echo $new_home | sed 's/\//\\\//g')
fi

mkdir $new_home
sed -i "1iexport HOME=$new_home_esc\ncd ~" .bash_profile


array=(.bashrc .inputrc .profile)

cp -vi ${array[*]} $new_home

echo "Copied ${array[*]} into $new_home." 1>&2
cd $new_home

cat >> .bashrc << EOF

#<<<<<<< BEGIN added by bad-cygwin.sh on 05/09/2018

# stuff from gentoo linux

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# Enable history appending instead of overwriting when exiting.  #139609
shopt -s histappend

alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'

PS1='\$(EXIT="\$?"; [ "\$EXIT" -ne "0" ] && echo "\[\e[31;1m\]\$EXIT|")\[\033]0;\u@\h:\w\007\]\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \\$\[\033[00m\] '

#Here are the customizations specific to cygwin use in prog 3:

alias npp="/cygdrive/c/Program\ Files\ \(x86\)/npp/notepad++.exe"


cboiler() {
  local file_name=hello_world.c
  [ -n "\$1" ] && file_name=\$1
  cat > \$file_name << ENDOFHELLOWORLD
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

echo "The script was probably successful."
echo "Your home directory (the default directory cygwin opens in, represented by ~) is set to $(tput bold)H:\cygwin_home$(tput sgr0) (/cygdrive/h/cygwin_home). This folder is accessible with Windows file explorer in $(tput bold)My Documents$(tput sgr0)."
echo "Some additional configurations have been appended to ~/.bashrc. For example, the ls command should be colorful. The default prompt PS1 has also been improved. Any non-zero exit code will appear before your prompt."
echo "You can try these new commands:"
echo 'cboiler [FILENAME] will create a "Hello World" in C.'
echo "$(tput bold)npp [FILENAME] &$(tput sgr0) will launch notepad++ directly from cygwin."

echo "To revert these changes, delete the cygwin_home folder, then: cd /home/\$USER && mv .bash_profile.backup .bash_profile"
echo "You must $(tput bold)restart cygwin$(tput sgr0) to finish setup. Type $(tput bold)exit$(tput sgr0)."
