#!/bin/bash

# This is the K-Pop configurator script. 
# It's gonna walk the user through some tweaks to their system, starting from the light and newbie-focused (color themes and rounded corners)
# and getting increasingly Arch-y until we arrive at direct and literal kernel management, in ascending order of difficulty.

clear
echo "~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~"
echo "  _  __          ____                ____             __ _       "
echo " | |/ /         |  _ \ ___  _ __    / ___|___  _ __  / _(_) __ _ "
echo " | ' /   _____  | |_) / _ \| '_ \  | |   / _ \| '_ \| |_| |/ _` |"
echo " | . \  |_____| |  __/ (_) | |_) | | |__| (_) | | | |  _| | (_| |"
echo " |_|\_\         |_|   \___/| .__/   \____\___/|_| |_|_| |_|\__, |"
echo "                           |_|                             |___/ "
echo
echo "~ ~ ~ ~ ~ ~ ~ ~ ~ ~ The customized experience ~ ~ ~ ~ ~ ~ ~ ~ ~ ~"
echo
echo
echo "Welcome to the K-Pop Configurator!"
echo
echo "In this script, we'll walk you through a series of apps, packages, and tweaks we consider to be the default K-Pop experience."
echo "However, some of the tools and selections here will not fit every taste profile and user preference. Therefore,"
echo "we've opted to walk you through these selctions, a la carte style, so you, the user retain total control of your system."
echo 
echo
sleep 2s

# TODO: I'd like to add the Dracula KDE and Konsole themes as an optional download, like the rest.
# 		Nord requires npm, hard pass. I should look into other theme options, though.

# Apt-bundle; official repositories
echo "First app bundle, some cli apps famous on reddit: micro (text editor with normal keybindss), neofetch (sys info),"
echo "htop (sys processes), ranger (file manager), cbonsai (terminal bling, bonsai tree), cmatrix (terminal bling, digital rain)"
echo "lynx (cli browser, kinda rough), googler (google search from console), & bmon (htop, but for networking/bandwidth)"
echo "These will be downloaded from the official Pop repositories via apt."
echo
read -p "Would you like to install this app bundle? [y/n]" varAppBundle
if [ $varAppBundle == 'y']; then
	sudo apt install -y micro neofetch htop ranger cbonsai cmatrix lynx googler bmon caca-utils
fi
echo

# ID
echo "alias neofetch='neofetch --w3m --source ~/.config/neofetch/wave.jpg'" >> ~/.bashrc
source ~/.bashrc
sudo hostname "k-pop"
sudo cp ./os-release /etc/os-release
sudo cp neofetch.conf ~/.config/neofetch/config.conf
sudo cp ./wave.jpg ~/.config/neofetch/wave.jpg
sudo cp ./motd /etc/motd

# Rounded Corners; source: https://github.com/matinlotfali/KDE-Rounded-Corners
echo "Now, let's start with the desktop. How about some rounded corners to your windows? They're very aesthetic, and don't serve"
echo "any other purpose. Still, they're very nice to look at. This will install from https://github.com/matinlotfali/KDE-Rounded-Corners"
echo
read -p "Would you like to install rounded corners? [y/n]" varRoundCorners
if [ $varRoundCorners == 'y']; then
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
	echo "If you decline to restart later (not-recommended), run > kwin_x11 --replace & < to activate them. And then restart."
	echo
fi
echo

# Krohnkite TWM; source: https://github.com/esjeon/krohnkite
echo "Would you like a tiling window manager? Tiling window managers are famous on reddit (see www.reddit.com/r/unixporn for examples),"
echo "for their efficient, sleek designs maximizing usable screen real estate. We'll be going with Krohnkite here,"
echo "but feel to try bismuth, or other WMs later! A word of advice: Keybinds aren't essential, but come highly recommended."
echo "So be sure and verify you keyboard shortcuts after reboot. This will install from https://github.com/esjeon/krohnkite"
echo
read -p "Would you like to install Krohnkite tiling window manager for KDE Plasma? [y/n]" varKrohn
if [ $varKrohn == 'y']; then
	plasmapkg2 -t kwinscript -i krohnkite.kwinscript
	mkdir -p ~/.local/share/kservices5/
	ln -s ~/.local/share/kwin/scripts/krohnkite/metadata.desktop ~/.local/share/kservices5/krohnkite.desktop
	echo
	echo "This may have activated now, it may not have. If you're screen looks weird, head to the system settings after restart."
	echo "System Settings > Window Management > KWin Scripts; there you'll see Krohnkite and it's little settings gear to the right."
	echo "We took the the liberty of installing the settings button, which isn't default for some reason, for easy access."
	echo "And if you hate it, just turn it off from the same menu. Believe us, it's not everyone's cup of tea, even if it is ours."
	echo
fi
echo	

# Powerline; source: https://github.com/b-ryan/powerline-shell
echo "Since we're on the shell now, how about about a powerline? It's a prompt for your terminal that MOSTLY serves as terminal bling,"
echo "with some git integration features for devs and tinkerers alike. We'll set this up for the bash shell."
echo "This will install from https://github.com/b-ryan/powerline-shell and add some lines to your ~/.bashrc file."
echo 

# TODO : Finish this up. We can even poll for shell, and install for each.

# Xonsh shell; official repositories // powerline source: https://github.com/jnoortheen/xontrib-powerline3
echo "If we're being honest, Bash is a sufficent shell for most users. However, the power users among us might prefer"
echo "a shell with a little more gumption. For this, we suggest xonsh. In addition to feature-parity with bash, and some QoL tweaks,"
echo "it also runs a python interpretter at the prompt. This empowers users to write bash-python hybrid scripts and"
echo "run both bash and python scripts natively from the same prompt, no fuss, no muss. This will install from the official repos."
echo
read -p "Would you like to install xonsh? [y/n]" varInstXonsh
if [ $varInstXonsh == 'y']; then
	#need to verify we have the right version of python installed
	sudo apt install -y python3 python3-pip
	sudo apt update -y
	sudo apt install xonsh
	echo
	read -p "Would you like to set xonsh as your default shell? [y/n]" varDefaultXonsh
	if [ $varDefaultXonsh == 'y']; then
		sudo chsh -s ~/.local/bin/xonsh
		echo
		echo "We're gonna wait for the full system reboot later to login to xonsh. Just an FYI."
		echo
	fi
	
	# TODO : Needs powerline question asked.
	# TODO : Needs neofetch aliasing performed for xonsh

fi

# Deb-Get; source: https://github.com/wimpysworld/deb-get
echo "Now, deb-get. This is a repository of third-party and proprietary applications, similar to apt itself." 
echo "Native installations of Microsoft Teams and Google Chrome can be found here, for instance."
echo "Some users have moral issues with proprietary software. We're not here to judge, just ask your preference."
echo "This will install form https://github.com/wimpysworld/deb-get"
echo
read -p "Would you like to install deb-get?  [y/n]" varDebGet
if [ $varDebGet == 'y']; then
	sudo apt install curl
	curl -sL https://raw.githubusercontent.com/wimpysworld/deb-get/main/deb-get | sudo -E bash -s install deb-get
fi
echo

# Pacstall; source: https://github.com/pacstall/pacstall
echo "Next app up is pacstall. This is the AUR for the Debian-family of distros. If you don't know what the"
echo "AUR is, it is a community-maintained package repository for Arch. Only this is that rebuilt for the Debian-family OSes."
echo "This grants more, newer software than the official repositories. This will install from https://github.com/pacstall/pacstall"
echo
read -p "Would you like to install pacstall? [y/n]" varPacstall
if [ $varPacstall == "y" ]; then
	sudo bash -c "$(curl -fsSL https://git.io/JsADh || wget -q https://git.io/JsADh -O -)"
fi
echo

# Dev/Staging apt channels; source: https://apt.pop-os.org/ - I think this is supposed to be deprecated. I can't find an alternative approach listed anywhere
echo "Would you like to upgrade to the dev/staging channels? This comes with a fair warning: unless you're an advanced Linux"
echo "user already, this may not be for you. These are high-volatility software channels, wherein the actual devs are actively"
echo "building. Brings a little more Arch-ness home to Pop_OS! As you're guaranteed to find bugs, don't be afraid to file reports"
echo "on Launchpad. In fact, it really helps out. Source for this information: https://apt.pop-os.org/"
echo
read -p "Would you like to add the development channels to K-Pop? [y/n]" varDevChannels
if [ $varDevChannels == 'y']; then
	# Staging Pop
	add-apt-repository "deb [arch=amd64] http://apt.pop-os.org/staging/master $(lsb_release -cs) main"
	# Staging Proprietary
	add-apt-repository "deb http://apt.pop-os.org/staging-proprietary $(lsb_release -cs) main"
	# Staging Ubuntu
	add-apt-repository "deb [arch=amd64] http://apt.pop-os.org/staging-ubuntu/master $(lsb_release -cs) main"
	sudo apt update -y
fi
echo

# Mainline; source: https://github.com/bkw777/mainline
echo "This one is both cool and terrifying. It helps you update your kernel, the very core of your system itself."
echo "Like the software, this can cause stability issues, as well as force recompiling of non-standard drivers"
echo "you may or may not have installed. The trade-off is that you have first row seats to new drivers and features as they're added."
echo "This is what the devs are working on. This is front line. This is Mainline. This will install from https://github.com/bkw777/mainline"
echo
read -p "So, would you like to install Mainline? [y/n]" varMainline
if [ $varMainline == 'y']
	sudo add-apt-repository ppa:cappelikan/ppa
	sudo apt update
	sudo apt install mainline
fi
echo

# Final cleanup, update, and reboot.
sudo apt clean -y && sudo apt autoremove -y
sudo apt update -y && sudo apt upgrade -y
sudo apt full-upgrade
sudo reboot
