#!/usr/bin/env bash

starting_script=`basename "$0"`
if [ "$starting_script" != "setup.sh" ]; then
	echo -e "\033[31m\aUhoh!\033[0m This script should not be run by itself."
	exit 1
fi;

echo -ne "\n- Copying dotfiles to their destination: "
cp -R ./resources/dotfiles/ ~/
echo -e "\033[32mDone\033[0m"