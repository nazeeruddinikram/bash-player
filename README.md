### What is bash-player?

"Bash-player is A Simple GUI (Graphical User Interface), for Mplayer/Mpv written in Shell."

### Why i should use Bash-player?
it's your choice :smiley:

###  MPLAYER + ZENITY == BASH-PLAYER!

Prview:

![SS01](https://raw.githubusercontent.com/wiki/levi0x0/bash-player/bash-playerSS01.png)

### How to install bash-player?

**Bash-player Requires 2 packages:**
* zenity
* mplayer or mpv

**Install mplayer:**
* on Ubuntu/Debian/LinuxMint: 
 `sudo apt-get install mplayer`

* on Fedora: 
 `sudo yum install mplayer`

* on Arch Linux: 
 `sudo pacman -S mplayer`

**Install zenity:**
* on Ubuntu/Debian/LinuxMint: 
 `sudo apt-get install zenity`

* on Fedora:
 `sudo yum install zenity`

* on Arch Linux:
 `sudo pacman -S zenity`

**Install bash-player**
* Download the Repository package: [Download]( https://github.com/levi0x0/bash-player/archive/master.zip)
* Unpac the zip file 

**from the terminal in bash-player dir run:**

`chmod +x install.sh`

**And install with this:**

`sudo ./install.sh install`

**We need root for moving files look at the source!**

* The package also available in the Arch Linux AUR repository
[Arch Linux AUR](https://aur.archlinux.org/packages/bash-player-git/)

###Upgrade bash-player###

Simply run:

`sudo bmplayer -update`


### How to uninstall bash-player?

Download the install.sh script here: [Download install.sh](https://raw.githubusercontent.com/levi0x0/bash-player/master/install.sh)

Run:

` chmod +x install.sh`

` ./install.sh uninstall`

###Mplayer_conifg.sh script###

"Mplayer_config.sh script will create custom mplayer config for you!"

Look at the wiki: [Wiki](https://github.com/levi0x0/bash-player/wiki/Subtitles)


**How to use?**

"Download the repository: [Download](https://github.com/levi0x0/bash-player/archive/master.zip)"

Run:

`chmod +x mplayer_config.sh`

` ./mplayer_config.sh -c`


_That's it!_
