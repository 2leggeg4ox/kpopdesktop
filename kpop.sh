#!/bin/bash

# This is a pretty simple shell script to swap GNOME out for KDE Plasma on Pop_OS!.
# Obviously, this'll work on most, if not all, Debian-based distributions where the default DE is GNOME.
# We're also going to ask the user if they'd like some additional packages and applications. 

clear
echo "~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ "
echo " _  __          ____               ___           _        _ _           "
echo "| |/ /         |  _ \ ___  _ __   |_ _|_ __  ___| |_ __ _| | | ___ _ __ "
echo "| ' /   _____  | |_) / _ \| '_ \   | || '_ \/ __| __/ _` | | |/ _ \ '__|"
echo "| . \  |_____| |  __/ (_) | |_) |  | || | | \__ \ || (_| | | |  __/ |   "
echo "|_|\_\         |_|   \___/| .__/  |___|_| |_|___/\__\__,_|_|_|\___|_|   "
echo "                          |_|                                           "
echo
echo "~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ The customized experience ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ "
echo
echo
echo "If you're asked to reboot at any point, please say no. We'll ask you when we're ready."
sleep 5s
echo

# Let's start by getting caught up to current.
sudo apt update -y && sudo apt upgrade -y
echo
echo "There. Now we're all caught up and it's on to the business."

# Next up: we gotta actually install KDE Plasma. 
echo
echo -e "KDE has 3 levels of installation: \n"
echo -e " 1. kde-plasma-desktop: Bare-minimum installation. Including basic utilities like a file manager, browser, and terminal emulator. \n"
echo -e " 2. kde-standard: Everything in kde-plasma-desktop with a standard suit of system utilities. \n"
echo -e " 3. kde-full: Everything in kde-standard with extra system utilities, games, and educational applications. \n"
echo 
echo -e "When prompted, please select sddm. It is the preferred login manager for KDE. gdm3 is preferred for GNOME."
read -p "Please select which you'd prefer. kde-standard (2) is recommended. [1/2/3/q]" varDistroLevel
if [ $varDistroLevel == 1]; then
	sudo apt install kde-plasma-desktop
elif [ $varDistroLevel == 2]; then
	sudo apt install kde-standard
elif [ $varDistroLevel == 3]; then
	sudo apt install kde-full
else
	echo "Invalid option. Exiting."
	clear
	exit 0
fi
echo

# Polling user for GNOME uninstall. 
echo 
echo "Next order of business, would we like to remove GNOME today? The question basically boils down"
echo "to whether or not you'd like to log into GNOME later OR would you like to have a smaller disk-footprint."
echo "Both are good options, each for their own reasons and use-cases."
echo
read -p "Are we removing GNOME? [y/n]" varRemoveGnome
if [ $varRemoveGnome == 'y']; then
	sudo apt remove --purge -y gnome-shell pop-cosmic
	sudo apt autoremove -y && sudo apt autoclean -y
fi
echo

# Debrief
echo "Now, we can get into the good stuff in the app packages. We'll start light and get more advanced (read: Arch-y) as we proceed."
echo "Remember, this is your system. You're in control of it. No pressure, but there's no better way to learn"
echo "than to do. We're just installing stuff, it's on you to run these tools' commands. However, if you say yes to every prompt,"
echo "you'll have a riced-out, rolling release on your hands as well, all from the comfort of Pop_OS! and family."
echo

# Rounded Corners
echo "Let's start with the desktop. How about some rounded corners to your windows? They're very aesthetic, and don't serve"
echo "any other purpose. Still, they're very nice to look at. This will install from https://github.com/matinlotfali/KDE-Rounded-Corners"
echo
read -p "Would you like to install rounded corners? [y/n]" varRoundCorners
if [ varRoundCorners == 'y']; then
	#source: https://github.com/matinlotfali/KDE-Rounded-Corners
	sudo apt install git cmake g++ gettext extra-cmake-modules qttools5-dev libqt5x11extras5-dev libkf5configwidgets-dev libkf5crash-dev libkf5globalaccel-dev libkf5kio-dev libkf5notifications-dev kinit-dev kwin-dev
	cd ~
	mkdir src
	cd src
	git clone https://github.com/matinlotfali/KDE-Rounded-Corners
	cd KDE-Rounded-Corners
	mkdir qt5build
	cd qt5build
	cmake ../ -DCMAKE_INSTALL_PREFIX=/usr -DQT5BUILD=ON
	make
	sudo make install
	cd ~
	echo
	echo "This requires reboot to take effect, so you won't see rounded corners yet."
	echo "If you decline to restart later (not-recommended), run [kwin_x11 --replace &] to activate them. And then restart."
	echo
fi
echo

# TODO: I'd like to add the Dracula KDE theme as an optional download, like the rest. Nord requires npm and is out for that reason.

# Krohnkite TWM
echo "Would you like a tiling window manager? Tiling window managers are famous on reddit,"
echo "for their efficient, sleek designs maximizing usable screen real estate. We'll be going with Krohnkite here,"
echo "but feel to try bismuth later! Keybinds aren't essential, but come highly recommended.This will install from https://github.com/esjeon/krohnkite"
echo
read -p "Would you like to install Krohnkite tiling window manager? [y/n]" varKrohn
if [ varKrohn == 'y']; then
	#source: https://github.com/esjeon/krohnkite
	plasmapkg2 -t kwinscript -i krohnkite.kwinscript
	mkdir -p ~/.local/share/kservices5/
	ln -s ~/.local/share/kwin/scripts/krohnkite/metadata.desktop ~/.local/share/kservices5/krohnkite.desktop
	echo
	echo "This may have activated now. If you're screen looks weird, head to the system settings after restart."
	echo "Window path: System Settings > Window Management > KWin Scripts; there you'll see Krohnkite. We took the"
	echo "the liberty of installing the settings button, which isn't default for some reason, for easy access."
	echo "And if you hate it, just turn it off from the same menu. Believe us, it's not everyone's cup of tea, even if it is ours."
	echo
fi
echo
	
# Apt-bundle
echo "For the second bundle, some simple cli apps famous on reddit: micro (editor with normal keybindss), neofetch (sys info),"
echo "htop (sys processes), ranger (file manager), cbonsai (terminal bling), cmatrix (terminal bling)"
echo "lynx (cli browser, kinda rough), googler (google search from console), xonsh (alternate shell powered by bash and python)"
echo "These will be downloaded from the official Pop repositories via apt."
read -p "Would you like to install this app bundle? [y/n]" varAppBundle
if [ varAppBundle == 'y']; then
	sudo apt install -y micro neofetch htop ranger cbonsai cmatrix lynx googler xonsh
fi
echo

# Deb-Get
echo "Now, deb-get. This is a repository of third-party and proprietary applications, similar to apt itself." 
echo "Native installations of Microsoft Teams and Google Chrome can be found here, for instance."
echo "Some users have moral issues with proprietary software. We're not here to judge, just ask your preference."
echo "This will install form https://github.com/wimpysworld/deb-get"
echo
read -p "Would you like to install deb-get?  [y/n]" varDebGet
if [ varDebGet == 'y']; then
	#source: https://github.com/wimpysworld/deb-get
	sudo apt install curl
	curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
fi
echo

# Pacstall
echo "Next app up is pacstall. This is the AUR for the Debian-family of distros. If you don't know what the"
echo "AUR is, it is a community-maintained package repository for Arch. Only this is that rebuilt for the Debian-family OSes."
echo "This grants more, newer software than the official repositories. This will install from https://github.com/pacstall/pacstall"
echo
read -p "Would you like to install pacstall? [y/n]" varPacstall
if [ varPacstall == "y" ]; then
	#source: https://github.com/pacstall/pacstall
	sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
fi
echo

# Staging apt channels
echo "Would you like to upgrade to the dev/staging channels? This comes with a fair warning: unless you're an advanced Linux"
echo "user already, this may not be for you. These are high-volatility software channels, wherein the actual devs are actively"
echo "building. Brings a little more Arch-ness home to Pop_OS! As you're guaranteed to find bugs, don't be afraid to file reports"
echo "on Launchpad. In fact, it really helps out. Source for this information: https://apt.pop-os.org/"
echo
read -p "Would you like to add the development channels to K-Pop? [y/n]" varDevChannels
if [varDevChannels == 'y']; then
	# source: https://apt.pop-os.org/; listed, due to questionable dating, I think this is supposed to be deprecated. I've asked reddit to see what else to do.
	# Staging Pop
	add-apt-repository "deb [arch=amd64] http://apt.pop-os.org/staging/master $(lsb_release -cs) main"
	# Staging Proprietary
	add-apt-repository "deb http://apt.pop-os.org/staging-proprietary $(lsb_release -cs) main"
	# Staging Ubuntu
	add-apt-repository "deb [arch=amd64] http://apt.pop-os.org/staging-ubuntu/master $(lsb_release -cs) main"
	sudo apt update -y
fi
echo

# Mainline
echo "This one is both cool and terrifying. It helps you update your kernel, the very core of your system itself."
echo "Like the software, this can cause stability issues, as well as force recompiling of non-standard drivers"
echo "you may or may not have installed. The trade-off is that you have first row seats to new drivers and features as they're added."
echo "This is what the devs are working on. This is front line. This is Mainline. This will install from https://github.com/bkw777/mainline"
echo
read -p "So, would you like to install Mainline? [y/n]" varMainline
if [ varMainline == 'y']
	#source: https://github.com/bkw777/mainline
	sudo add-apt-repository ppa:cappelikan/ppa
	sudo apt update
	sudo apt install mainline
fi
echo

# Clean up, identifications
sudo hostname "k-pop"

echo "Rebooting"
sleep 2s
sudo reboot
