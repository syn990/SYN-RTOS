#!/bin/sh

# Actually read this script, make changes before running it, and understand each line of code before committing yourself to a build.
# If you lack the understanding or glaze over it, you could destroy your existing system.

# Future ambitions include setting up non-standard file-system such as xfs, zfs 
# or btrfs for block-device backups instead of individual files.

# Encryption is a very real possibility to be baked in both the live and
# persistent enviroment.

loadkeys uk					# Setup the keyboard layout
timedatectl set-ntp true			# Setup NTP so the time is up-to-date

systemctl start dhcpcd.service			# Setup DHCP on boot (seems to need manually doing recently, perhaps releng is borked)


#  Stale. Also really scary... This is a "parted" script that aggressivley erases
#  the disks of target /dev/sda which is inaccurate and dangerous to assume.

clear
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

	ROOT_DISK_990="/dev/sda"	# Drive to be wiped
	ROOT_PART_990="/dev/sda2"	# The root partition
	BOOT_PART_990="/dev/sda1"	# The boot partition
	
parted --script $ROOT_DISK_990 mklabel gpt mkpart primary fat32 1Mib 200Mib set 1 boot on
parted --script $ROOT_DISK_990 mkpart primary ext4 201Mib 100%
	mkfs.vfat -F 32 $BOOT_PART_990
        mkfs.ext4 -F $ROOT_PART_990
        	mount $ROOT_PART_990 /mnt
			mkdir /mnt/boot/
			mount $BOOT_PART_990 /mnt/boot
 
echo "     _______.____    ____ .__   __.        .______     .___________.  ______        _______."
echo "    /       |\   \  /   / |  \ |  |        |   _  \    |           | /  __  \      /       |"
echo "   |   (----  \   \/   /  |   \|  |  ______|  |_)  |    ---|  |---- |  |  |  |    |   (---- "
echo "    \   \      \_    _/   |  .    | |______|      /        |  |     |  |  |  |     \   \    "
echo ".----)   |       |  |     |  |\   |        |  |\  \----.   |  |     |   --'  | .----)   |   "
echo "|_______/        |__|     |__| \__|        | _|  ._____|   |__|      \______/  |_______/    "

# You can add/remove packages in these variables. It's done this way so you can see waht's being installed. The variables are meaningless and pacstrap does not care,
# It's been done this way so you can see what packages are being installed so you can make sensible decisions about what you want on the result system.
# Literally, all you need to do is ensure the package name is present and it's a valid package, and pacstrap will install it.

	BASE_990="base base-devel dosfstools fakeroot gcc linux linux-firmware pacman-contrib sudo zsh"
	SYSTEM_990__="alsa-utils archlinux-xdg-menu dhcpcd dnsmasq hostapd iwd pulseaudio python-pyalsa"
	CONTROL_990_="lxrandr obconf-qt pavucontrol-qt"
	WM_990______="openbox xcompmgr xorg-server xorg-xinit tint2"
	CLI_990_____="git htop man nano reflector rsync wget"
	GUI_990_____="engrampa feh kitty kwrite pcmanfm-qt"
	FONT_990____="terminus-font ttf-bitstream-vera"
	CLI_XTRA_990="android-tools archiso binwalk brightnessctl hdparm hexedit lshw ranger sshfs yt-dlp"	
	GUI_XTRA_990="audacity chromium gimp kdenlive obs-studio openra spectacle vlc"
	VM_XTRA_990_="edk2-ovmf libvirt qemu-desktop virt-manager virt-viewer"
	
		SYNSTALL="$BASE_990 $SYSTEM_990__ $CONTROL_990_ $WM_990______ $CLI_990_____ $GUI_990_____ $FONT_990____ $CLI_XTRA_990 $GUI_XTRA_990 $VM_XTRA_990_"

echo  " ___  _   ___ ___ _____ ___    _   ___ "
echo  "| _ \/_\ / __/ __|_   _| _ \  /_\ | _ |"""
echo  "|  _/ _ \ (__\__ \ | | |   / / _ \|  _/"
echo  "|_|/_/ \_\___|___/ |_| |_|_\/_/ \_\_|  "
echo "Installing packages to the resulting system."

# If you wanted to add your own packages:
# Add packages after $SYNSTALL like this "pacstrap /mnt $SYNSTALL firefox mixxx virtualbox some-other-package"

	pacman -Syy && reflector -c "GB" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist 	# Unsure why the mirrorlist has broken. I might have removed this for some reason?
	pacman-key --init									# For some reason the keys seems to fail after packaging an ISO
	pacman-key --populate archlinux								# This will force pacman to download the correct keys and apply them for the default archlinux repo
	
	pacstrap /mnt $SYNSTALL									# This is the pacstrap that combines all the packages in the variables above
    
echo  " _______  _______  __    _  _______  _______  _______  _______  _______ "
echo  "|       ||       ||  |  | ||       ||       ||       ||   _   ||  _    |"
echo  "|    ___||    ___||   |_| ||    ___||  _____||_     _||  |_|  || |_|   |"
echo  "|   | __ |   |___ |       ||   |___ | |_____   |   |  |       ||       |"
echo  "|   ||  ||    ___||  _    ||    ___||_____  |  |   |  |       ||  _   | "
echo  "|   |_| ||   |___ | | |   ||   |     _____| |  |   |  |   _   || |_|   |"
echo  "|_______||_______||_|  |__||___|    |_______|  |___|  |__| |__||_______|"
echo  "Generating filesystem table with boot information in respect to UUID assignment"

	genfstab -U /mnt >> /mnt/etc/fstab 			

echo  "  ____   ___ _____ _____ ___ _     _____ ____  "
echo  " |  _ \ / _ \_   _|  ___|_ _| |   | ____/ ___| "
echo  " | | | | | | || | | |_   | || |   |  _| \___ \ "
echo  " | |_| | |_| || | |  _|  | || |___| |___ ___) |"
echo  " |____/ \___/ |_| |_|   |___|_____|_____|____/ "
echo  " Copying the 1.root_filesystem_overlay materials to the result system root directory"

	ROOTFSOVERLAY990="/root/SYN-RTOS-V3/1.root_filesystem_overlay/*"
	cp -Rv $ROOTFSOVERLAY990 /mnt/ && clear
	echo "Filesystems created"
	echo "Partitions mounted"
	echo "Pacstrap completed"
	echo "Fstab generated"
	echo "cp -Rv $ROOTFSOVERLAY990 /mnt/ was successful"
	
echo "     _______.____    ____ .__   __.        .______     .___________.  ______        _______."
echo "    /       |\   \  /   / |  \ |  |        |   _  \    |           | /  __  \      /       |"
echo "   |   (----  \   \/   /  |   \|  |  ______|  |_)  |    ---|  |---- |  |  |  |    |   (---- "
echo "    \   \      \_    _/   |  .    | |______|      /        |  |     |  |  |  |     \   \    "
echo ".----)   |       |  |     |  |\   |        |  |\  \----.   |  |     |   --'  | .----)   |   "
echo "|_______/        |__|     |__| \__|        | _|  ._____|   |__|      \______/  |_______/    "
echo ""
echo "Stage Zero Complete - You now need to arch-chroot into the new system to continue building."
echo "Assume the root file system was mounted on /mnt, you would need to type ""arch-chroot /mnt"""
