#!/usr/bin/env bash

starting_script=`basename "$0"`
if [ "$starting_script" != "setup.sh" ]; then
	echo -e "\033[31m\aUhoh!\033[0m This script should not be run by itself."
	exit 1
fi;

# GIT
echo -e "\n- Git: "

echo -ne "\n  - Installation Status      "

GIT_NEEDS_TO_BE_INSTALLED="no"
if [ -n "$(which git)" ]; then
	if [ ! -n "$(git --version) | grep "Apple"" ]; then # we don't want the Apple version
		echo -e "\033[33mNeeds upgrade\033[0m"
		GIT_NEEDS_TO_BE_INSTALLED="yes"
	else
		echo -e "\033[32mInstalled\033[0m"	
	fi;
else
	echo -e "\033[31mNot Installed\033[0m"
	GIT_NEEDS_TO_BE_INSTALLED="yes"
fi;

if [ "$GIT_NEEDS_TO_BE_INSTALLED" = "yes" ]; then
	apt install git
fi;

echo -e "  - Setting up your Git Identity …"

# Fall back to the Apple ID as the git e-mail address if none set yet
EMAIL_ADDRESS="$(git config --global user.email)"
echo -e "\n    What's the e-mail address to use with Git? (default: $EMAIL_ADDRESS)"
echo -ne "    > \033[34m\a"
read
echo -e "\033[0m\033[1A\n"
[ -n "$REPLY" ] && EMAIL_ADDRESS=$REPLY

git config --global user.email "$EMAIL_ADDRESS"

# Suggest the username as git user name
if [ -z "$(git config --global user.name)" ]; then
	USERNAME="$(whoami)"
else
	USERNAME="$(git config --global user.name)"
fi;
echo -e "    What's the username to use with Git? (default: $USERNAME)"
echo -ne "    > \033[34m\a"
read
echo -e "\033[0m\033[1A\n"
[ -n "$REPLY" ] && USERNAME=$REPLY

git config --global user.name "$USERNAME"

echo -ne "  - Configuring Git        "

git config --global color.ui true

echo -e "\033[32mOK\033[0m"