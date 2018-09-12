#!/usr/bin/env bash

starting_script=`basename "$0"`
if [ "$starting_script" != "setup.sh" ]; then
	echo -e "\033[31m\aUhoh!\033[0m This script should not be run by itself."
	exit 1
fi;

# Composer
apt install composer

# VS Code
apt install code

# GitKraken
apt install gitkraken

# Rust
curl https://sh.rustup.rs -sSf | sh

# Python 3
apt get install python3-dev