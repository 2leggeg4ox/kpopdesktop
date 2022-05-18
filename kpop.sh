#!/bin/bash

# This is a pretty simple shell script to swap GNOME out for KDE Plasma on Pop_OS!.
# Obviously, this'll work on most, if not all, Debian-based distributions where the default DE is GNOME.
# We're also going to ask the user if they'd like to run a config script to install additional packages and apps.



clear
echo "~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ "
echo " _  __          ____               ___           _        _ _           "
echo "| |/ /         |  _ \ ___  _ __   |_ _|_ __  ___| |_ __ _| | | ___ _ __ "
echo "| ' /   _____  | |_) / _ \| '_ \   | || '_ \/ __| __/ _` | | |/ _ \ '__|"
echo "| . \  |_____| |  __/ (_) | |_) |  | || | | \__ \ || (_| | | |  __/ |   "
echo "|_|\_\         |_|   \___/| .__/  |___|_| |_|___/\__\__,_|_|_|\___|_|   "
echo "                          |_|                                           "
echo
echo "~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ The basic experience ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~"
sleep 2s
echo

# Let's start by updating. Gotta work with the latest and greatest.

# TODO: Check the actual system OS: exit if non-Debian, install pop repos if Debian/Ubuntu, proceed if Pop! already

sudo apt update -y && sudo apt upgrade -y
echo

# Next up: we gotta actually install KDE Plasma. 
echo -e "KDE has 3 levels of installation: \n"
echo -e " 1. kde-plasma-desktop: Bare-minimum installation. Including basic utilities like a file manager, browser, and terminal emulator. \n"
echo -e " 2. kde-standard: Everything in kde-plasma-desktop with a standard suit of system utilities. \n"
echo -e " 3. kde-full: Everything in kde-standard with extra system utilities, games, and educational applications. \n"
echo 
echo -e "When prompted, please select sddm - it's the preferred login manager for KDE Plasma.\n"
echo
read -p "Please select which level you'd prefer. kde-standard (2) is recommended. [1/2/3/q]" varDistroLevel
if [ $varDistroLevel == 1]; then
	sudo apt install kde-plasma-desktop
elif [ $varDistroLevel == 2]; then
	sudo apt install kde-standard
elif [ $varDistroLevel == 3]; then
	sudo apt install kde-full
else
	echo "Invalid option. Exiting. Just re-run the script, no worries."
	clear
	exit 0
fi
echo

# Polling user for GNOME uninstall. 
echo -e "Next order of business, would we like to remove GNOME today? The question basically boils down \n"
echo -e "to whether or not you'd like to log into GNOME later OR would you like to have a smaller disk-footprint.\n"
echo -e "Both are good options, each for their own reasons and use-cases.\n"
echo
read -p "Are we removing GNOME today? [y/n]" varRemoveGnome
if [ $varRemoveGnome == 'y']; then
	sudo apt remove --purge -y gnome-shell pop-cosmic
	sudo apt autoremove -y && sudo apt autoclean -y
fi
echo

# Optional customization
echo -e "In addition to this basic DE-swap, we've written an optional configuration script to flesh out your user experience.\n"
echo -e "If you've ever wandered into reddit.com/r/unixporn, this might be for you. It'll walk you through various apps and tools\n"
echo -e "chosen specifically to give you the option of going full-Arch here in Pop! in an well-explained, a la carte format.\n"
echo 
read -p "Would you like to run the configurator script? [y/n]" varConfig
if [ $varConfig == 'n']; then
	echo
	echo "If you didn't remove GNOME, don't forget to toggle the enivronment you're logging into at the login screen."
	echo
	echo "Rebooting now. See you on the other side, cowboy. Hit CTRL+C now if you don't want to reboot (reboot recommended)."
	sleep 5s
	sudo reboot
else
	echo
	sudo chmod +x ./kpop-rice.sh
	bash ./kpop-rice.sh
fi
