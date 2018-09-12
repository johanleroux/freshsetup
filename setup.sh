#!/usr/bin/env bash

# UTILS
function showheader {
	# Clear the screen
	echo -ne "\033c"

	echo "Fresh Setup of a Linux Web Development Environment"
}

function askforreboot {
	echo -e "\n\033[36mA reboot is required. After rebooting re-run this script, it will continue right where it left so no worries there 😊\033[0m"
	echo -e "\nDo you want to reboot now? [Y/n]"
	echo -ne "> \033[94m\a"
	read -r
	echo -e "\033[0m"

	if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
		echo -e "\n\033[93mRebooting now. See you on the other side …\033[0m\n"
		# sudo shutdown -r now
		osascript -e 'tell app "System Events" to restart'
		exit;
	fi;
}

function askforrestart {
	echo -e "\n\033[36mA restart of Terminal is required. After restarting Terminal re-run this script, it will continue right where it left so no worries there 😊\033[0m"
	echo -e "\nDo you want to exit Terminal now? [Y/n]"
	echo -ne "> \033[94m\a"
	read -r
	echo -e "\033[0m"

	if [[ $REPLY =~ ^[Yy]$ ]] || [[ -z $REPLY ]]; then
		echo -e "\n\033[93mRestarting Terminal. See you on the other side …\033[0m\n"
		killall "Terminal" &> /dev/null
		exit;
	fi;
}

function pressanykeytocontinue {
	echo -e "\nPress any key to continue …"
	read -n 1
}

function checksudoandprompt {
	if [ -n "$(sudo -nl 2>&1 | grep -E "password is required$")" ]; then
		echo -ne "\a"
		sudo -v
	fi;
}

function checksudoandexit {
	if [ -n "$(sudo -nl 2>&1 | grep -E "password is required$")" ]; then
		echo -e "\n\033[31m\aUhoh!\033[0m Without sudo privileges the script can't continue"
		exit 1
	fi;
}

# START
showheader

# Prevent from running this script via `sudo`
if [[ $EUID == 0 ]]; then
    echo -e "\n\033[31m\aUhoh!\033[0m It looks like you're running this script using sudo."
    exit 1
fi;

# STEP 0
echo -e "\nSudo privileges are required."
echo -e "Please enter your password"
checksudoandprompt

checksudoandexit

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# STEP 1 - Defaults
echo -e "\n\033[4m\033[1mStep 1: Linux Defaults\033[0m"
source ./scripts/1-linux-defaults.sh
echo -e "\n\033[32mStep 1: Completed!\033[0m"

# STEP 2 - SSH
echo -e "\n\033[4m\033[1mStep 2: SSH\033[0m"
source ./scripts/2-ssh.sh
echo -e "\n\033[32mStep 2: Completed!\033[0m"

# STEP 3 - Essentials
echo -e "\n\033[4m\033[1mStep 3: Essentials\033[0m"
source ./scripts/3-essentials.sh
echo -e "\n\033[32mStep 3: Completed!\033[0m"

# STEP 4 - Dotfiles
echo -e "\n\033[4m\033[1mStep 4: Dotfiles\033[0m"
source ./scripts/4-dotfiles.sh
echo -e "\n\033[32mStep 4: Completed!\033[0m"

# STEP 5 - Software
echo -e "\n\033[4m\033[1mStep 5: Software\033[0m"
source ./scripts/5-software.sh
echo -e "\n\033[32mStep 5: Completed!\033[0m"

echo -e "\n\n\n\n\n\033[32mLinux setup completed!\033[0m\n"
exit