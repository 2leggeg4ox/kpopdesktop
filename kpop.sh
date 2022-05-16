#!/bin/bash

# This is a pretty simple shell script to swap GNOME out for KDE Plasma on Pop_OS!.
# Obviously, this'll work on most, if not all, Debian-based distributions where the default DE is GNOME.
# We're also going to ask the user if they'd like some additional packages and applications. 

clear
echo " _  __          ____               ___           _        _ _           "
echo "| |/ /         |  _ \ ___  _ __   |_ _|_ __  ___| |_ __ _| | | ___ _ __ "
echo "| ' /   _____  | |_) / _ \| '_ \   | || '_ \/ __| __/ _` | | |/ _ \ '__|"
echo "| . \  |_____| |  __/ (_) | |_) |  | || | | \__ \ || (_| | | |  __/ |   "
echo "|_|\_\         |_|   \___/| .__/  |___|_| |_|___/\__\__,_|_|_|\___|_|   "
echo "                          |_|                                           "
echo -e "\n \n"

# Let's start by getting caught up to current.
sudo apt update -y && sudo apt full-upgrade -y

# Next up: we gotta actually install KDE Plasma. 
# We're gonna explain the options. 
# Then poll the user which they'd prefer.
# Finally, we'll do the damn thing. Let's go!!

echo -e "KDE has 3 levels of installation: \n"
echo -e " 1. kde-plasma-desktop: Bare-minimum installation. Including basic utilities like a file manager, browser, and terminal emulator. \n"
echo -e " 2. kde-standard: Everything in kde-plasma-desktop with a standard suit of system utilities. \n"
echo -e " 3. kde-full: Everything in kde-standard with extra system utilities, games, and educational applications. \n"
echo -e "\n"
echo -e "\n"
echo -e "When prompted, please select sddm. It is the preferred login manager for KDE. gdm3 is preferred for GNOME."

#Poll
read -p "Please select which you'd prefer. kde-standard (2) is recommended. [1/2/3/q]" varDistroLevel

# Do it like Nike or whatever.
if [ $varDistroLevel == 1]; then
	sudo apt install kde-plasma-desktop
elif [ $varDistroLevel == 2]; then
	sudo apt install kde-standard
elif [ $varDistroLevel == 3]; then
	sudo apt install kde-full
else
	echo -e "Invalid option. Exiting. \n"
	clear
	exit 0
fi



sleep 1s
sudo apt install -y curl apt-transport-https
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo add-apt-repository -y ppa:oguzhaninan/stacer
sudo add-apt-repository -y ppa:teejee2008/timeshift
sudo add-apt-repository ppa:lazygit-team/release
sudo add-apt-repository ppa:lutris-team/lutris
sudo apt-get update
clear
echo "Downloading external packages."
sleep 1s
wget -P ~/Downloads -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
wget -P ~/Downloads -O tabby.deb "https://github.com/Eugeny/tabby/releases/tag/v1.0.168/tabby-1.0.168-linux.deb"
clear
echo "Installing K-Pop App Bundle."
sleep 1s
sudo apt update
sudo apt install -y lazygit lutris wine micro openssh-server xonsh brave-browser rsync htop joplin neofetch lynx googler cbonsai cmatrix ranger nano steam krita gimp ubuntu-restricted-extras unattended-upgrades
sudo dpkg -i ~/Downloads/discord.deb
sudo dpkg -i ~/Downloads/tabby.deb
sudo apt install -y stacer timeshift
sudo apt-get -f install
clear
echo "Configuring."
sleep 1s
sudo ufw allow ssh
sudo systemctl status ssh
sudo dpkg-reconfigure --priority=low unattended-upgrades
sudo echo "kpop" >> /etc/hostname
echo "Double checking dependencies from the App Bundle."
sleep 1s
sudo apt --fix-broken install
clear
echo "Cleanup time!"
sleep 1s
sudo apt autoremove --purge
clear
sudo apt install -y plasma-nm
sudo apt purge -y dolphin kwrite konsole firefox
echo "Removing Gnome"
sudo apt-get purge gnome
sudo apt autoremove --purge
echo "Rebooting"
sleep 2s
sudo reboot
