#!/bin/bash
# install.sh
#
# Install bash-player to Your System
# Author: levi (levi0x0) "http://github.com/levi0x0/bash-player"
# Version: 0.1
# Date: 11-04-2014

#bin dir for bmplayer.sh
bin="/usr/bin/"
#pixmap dir for bash-player.png
pixmaps="/usr/share/pixmaps/"
#desktop dir for bash-player.desktop
desktop="/usr/share/applications"

#version
version="0.1"

#status variables
debug="[DEBUG]"
error="[ERROR]"
exit="[EXIT]"

#banner
banner="Bash-player Installer $version Copyright 2014 (C) levi (levi0x0)"

installbp() {
	echo "-=-=-=-=-=-=-=-=-=-=-="
	echo "Bash-Player Installer"
	echo "======================"
	if [ $UID != 0 ];then
		echo "[!] Please run as root! we need to move files."
		echo -e "Look at the source! (:\n"
		exit
	else
		echo "[!] We are ready to Go!"
	fi
	#moving bmplayer.sh to /usr/bin
	echo "[!] Moving bmplayer.sh.."
	mv bmplayer.sh $bin/bmplayer
	chmod +x $bin/bmplayer
	#moving the icon tho pixmaps
	echo "[!] Moving bash-player.png.."
	mv bash-player.png $pixmaps
	#moving desktop 
	echo "[!] Moving bash-player.desktop.."
	mv bash-player.desktop $desktop
	echo -e "\nOK! Bash-player installed.!"
	echo "Use your Application menu to start bash-player"
	echo -e "Or run 'bmplayer' from the terminal..\n" 
}

uninstallbp() {
	echo "-=-=-=-=-=-=-=-=-=-=-="
	echo "Bash-Player uninstaller"
	echo "======================"
	if [ $UID != 0 ];then
		echo "[!] Please run as root! we need to remove files."
		echo -e "Look at the source! (:\n"
		exit
	else
		echo "[!] We are ready to Go!"
	fi
	#moving bmplayer.sh to /usr/bin
	echo "[!] removing bmplayer.."
	rm -r $bin/bmplayer
	#moving the icon tho pixmaps
	echo "[!] rmoving bash-player.png.."
	rm -r $pixmaps/bash-player.png
	#moving desktop 
	echo "[!] removing bash-player.desktop.."
	rm -r $desktop/bash-player.desktop
	echo -e "\nOK! Bash-player Not installed.!"
	echo -e "Written by levi (http://github.com/levi0x0)\n"
}

if [ -z $1 ]; then
	echo $banner
	echo -e "\nUsage: $0 [ install | uninstall ]"
	echo -e "\n\tTo Install: $0 install"
	echo -e "\tTo Uninstall: $0 uninstall"
	echo -e "\nThat's it! (:"
	exit
elif [[ $1 == "install" ]];then
	installbp
elif [[ $1 == "uninstall" ]];then 
	uninstallbp
fi
