#!/bin/sh

# Actually read this script, make changes before running it, and understand each line of code before committing yourself to a build.
# If you lack the understanding or glaze over it, you could destroy your existing system.

# Future ambitions include setting up non-standard file-system such as xfs, zfs 
# or btrfs for block-device backups instead of individual files.

# Encryption is a very real possibility to be baked in both the live and
# persistent enviroment.

loadkeys uk			# Setup the keyboard layout
timedatectl set-ntp true	# Setup NTP so the time is up-to-date

#  Stale. Also really scary... This is a "parted" script that aggressivley erases
#  the disks of target /dev/sda which is inaccurate and dangerous to assume.

echo "____    __    ____  __  .______    __  .__   __.   _______ "
echo "\   \  /  \  /   / |  | |   _  \  |  | |  \ |  |  /  _____|"
echo " \   \/    \/   /  |  | |  |_)  | |  | |   \|  | |  |  __  "
echo "  \            /   |  | |   ___/  |  | |  .    | |  | |_ | "
echo "   \    /\    /    |  | |  |      |  | |  |\   | |  |__| | "
echo "    \__/  \__/     |__| | _|      |__| |__| \__|  \______| "
echo " ___________    ____  _______ .______     ____    ____ .___________. __    __   __  .__   __.   _______ "
echo "|   ____\   \  /   / |   ____||   _  \    \   \  /   / |           ||  |  |  | |  | |  \ |  |  /  _____|"
echo "|  |__   \   \/   /  |  |__   |  |_)  |    \   \/   /   ---|  |---- |  |__|  | |  | |   \|  | |  |  __  "
echo "|   __|   \      /   |   __|  |      /      \_    _/       |  |     |   __   | |  | |  .    | |  | |_ | "
echo "|  |____   \    /    |  |____ |  |\  \----.   |  |         |  |     |  |  |  | |  | |  |\   | |  |__| | "
echo "|_______|   \__/     |_______|| _|  ._____|   |__|         |__|     |__|  |__| |__| |__| \__|  \______| "
echo "If you didn't read the source properly you've probably wiped all your precious data..."                                                        

# This currently wipes sda, without any prompt. We need it to create a device lable as this will help bootctl be more predictable						   
# It's set to gpt so a different script is needed for MBR setups. 

parted --script /dev/sda mklabel gpt mkpart primary fat32 1Mib 200Mib set 1 boot on
parted --script /dev/sda mkpart primary ext4 201Mib 100%
	mkfs.vfat -F 32 /dev/sda1
        mkfs.ext4 -F /dev/sda2
        	mount /dev/sda2 /mnt
        	mkdir /mnt/boot/
		mount /dev/sda1 /mnt/boot
 
echo "     _______.____    ____ .__   __.        .______     .___________.  ______        _______."
echo "    /       |\   \  /   / |  \ |  |        |   _  \    |           | /  __  \      /       |"
echo "   |   (----  \   \/   /  |   \|  |  ______|  |_)  |    ---|  |---- |  |  |  |    |   (---- "
echo "    \   \      \_    _/   |  .    | |______|      /        |  |     |  |  |  |     \   \    "
echo ".----)   |       |  |     |  |\   |        |  |\  \----.   |  |     |   --'  | .----)   |   "
echo "|_______/        |__|     |__| \__|        | _|  ._____|   |__|      \______/  |_______/    "

# You can add/remove packages in these variables. It's done this way so you can see waht's being installed. The variables are meaningless and pacstrap does not care,
# It's been done this way so you can see what packages are being installed so you can make sensible decisions about what you want on the result system.
# Literally, all you need to do is ensure the package name is present and it's a valid package, and pacstrap will install it.

	BASE_990="base base-devel dosfstools fakeroot gcc linux linux-firmware pacman-contrib reflector sudo zsh"			# Base system"
	DAEMONS_990="alsa-utils archlinux-xdg-menu dhcpcd dnsmasq hostapd iwd man pulseaudio python-pyalsa" 				# System Daemons
	UTILS_990="lxrandr obconf-qt pavucontrol-qt tint2conf"										# System Utilties
	SYS-UI-990="openbox xcompmgr xorg-server xorg-xinit tint2"									# System UI
	CLI-APP_990="brightnessctl git hdparm htop lshw nano ranger reflector rsync sshfs wget yt-dlp"					# CLI applications
	GUI-APP_990="audacity chromium engrampa feh gimp kdenlive kitty kwrite obs-studio openra pcmanfm-qt spectacle vlc"		# GUI applications
	FONTS_990="terminus-font ttf-bitstream-vera" 											# Fonts
	BUILD-SET_990="android-tools archiso binwalk edk2-ovmf git hexedit libvirt qemu-desktop virt-manager virt-viewer"		# SYN-RTOS Virtualization & Build set
	SYN-RTOS-990="$BASE_990 $DAEMONS_990 $UTILS_990 $CLI-APP_990 $GUI-APP_990 $FONTS_990 $BUILD-SET_990"				# Mastar Variable

echo  " ___  _   ___ ___ _____ ___    _   ___ "
echo  "| _ \/_\ / __/ __|_   _| _ \  /_\ | _ |"""
echo  "|  _/ _ \ (__\__ \ | | |   / / _ \|  _/"
echo  "|_|/_/ \_\___|___/ |_| |_|_\/_/ \_\_|  "
echo "Installing packages to the resulting system - this might take a while so go do somthing else or just watch the screen for ages"

# If you wanted to add your own packages:
# Add packages after $SYN-RTOS-990 like this "pacstrap /mnt $SYN-RTOS-990 firefox mixxx libmp3"...

	pacstrap /mnt $SYN-RTOS-990 
    

echo  " _______  _______  __    _  _______  _______  _______  _______  _______ "
echo  "|       ||       ||  |  | ||       ||       ||       ||   _   ||  _    |"
echo  "|    ___||    ___||   |_| ||    ___||  _____||_     _||  |_|  || |_|   |"
echo  "|   | __ |   |___ |       ||   |___ | |_____   |   |  |       ||       |"
echo  "|   ||  ||    ___||  _    ||    ___||_____  |  |   |  |       ||  _   | "
echo  "|   |_| ||   |___ | | |   ||   |     _____| |  |   |  |   _   || |_|   |"
echo  "|_______||_______||_|  |__||___|    |_______|  |___|  |__| |__||_______|"
# Generate filesystem table with boot information in respect to UUID assignment 

	genfstab -U /mnt >> /mnt/etc/fstab 			

echo  "  ____   ___ _____ _____ ___ _     _____ ____  "
echo  " |  _ \ / _ \_   _|  ___|_ _| |   | ____/ ___| "
echo  " | | | | | | || | | |_   | || |   |  _| \___ \ "
echo  " | |_| | |_| || | |  _|  | || |___| |___ ___) |"
echo  " |____/ \___/ |_| |_|   |___|_____|_____|____/ "
# Move the 1.root_filesystem_overlay materials and cheap boot method across to the result system

	cp -Rv /root/SYN-RTOS-V3/1.root_filesystem_overlay/* /mnt/
	
echo "     _______.____    ____ .__   __.        .______     .___________.  ______        _______."
echo "    /       |\   \  /   / |  \ |  |        |   _  \    |           | /  __  \      /       |"
echo "   |   (----  \   \/   /  |   \|  |  ______|  |_)  |    ---|  |---- |  |  |  |    |   (---- "
echo "    \   \      \_    _/   |  .    | |______|      /        |  |     |  |  |  |     \   \    "
echo ".----)   |       |  |     |  |\   |        |  |\  \----.   |  |     |   --'  | .----)   |   "
echo "|_______/        |__|     |__| \__|        | _|  ._____|   |__|      \______/  |_______/    "
echo ""
echo "State Zero Complete - You now need to chroot into the new system to continue building."
echo "Assume the root file system was mounted on /mnt, you would need to type ""arch-chroot /mnt"""
