#!/bin/bash

# >>> Welcome, I guess. I got tired of doing all this manually. So here I am.
clear
echo -e "Welcome to the K-Pop installer!\n\n"
sleep 2s
echo "Let's begin."
sleep 1s
clear
echo "Checking for and installing any applicable system updates."
sleep 1s
sudo apt update && sudo apt upgrade
clear
echo "Installing repositories and configuring them."
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
echo "And now, we're installing KDE/Plasma. Please select sddm when prompted."
sleep 2s
sudo apt install kde-full
sudo apt install -y plasma-nm
sudo apt purge -y dolphin kwrite konsole firefox
echo "Removing Gnome"
sudo apt-get purge gnome
sudo apt autoremove --purge
echo "Rebooting"
sleep 2s
sudo reboot
