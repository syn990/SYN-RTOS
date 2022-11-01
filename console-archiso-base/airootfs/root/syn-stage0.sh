#!/bin/sh

# Although generic and not neccessary for a zero-touch solution to implement
# human-required settings such as keyboard locale, this is neccessary to ensure
# an rescue/escape shell can still be recovered with manual intervention.

# These should be baked into the ISO instead of being defined as shell variables
# when these are already initialised after the fact.

# Set keyboard layout in TTY to UK
    loadkeys uk

# Setting up NTP should also be baked into the ISO rather than being applied
# with a doublewhammy. These configurations bear nothing for the resulting
# Deployment and are mearly an artifact of an adapted setup enviroment
# rather than being curiated into it's own distingused identity.
    
# Setup NTP
    timedatectl set-ntp true

# Stale and soon to be trimmed. This is a parted script that aggressivley erases
# the disks of target /dev/sda which is inaccurate and dangerous to assume.
# Instead rather it's worth investigating if anything is salvagable
# from the automated noob-installer that recently hit the repos.

# Other ambitions include setting up non-standard file-system such as xfs, zfs 
# or btrfs for block-device backups instead of individual files.
# Encryption is a very real possibility to be baked in both the live and
# persistent envrooment.

echo  "____    __    ____  __  .______    __  .__   __.   _______ "
echo  "\   \  /  \  /   / |  | |   _  \  |  | |  \ |  |  /  _____|"
echo  " \   \/    \/   /  |  | |  |_)  | |  | |   \|  | |  |  __  "
echo  "  \            /   |  | |   ___/  |  | |  .    | |  | |_ | "
echo  "   \    /\    /    |  | |  |      |  | |  |\   | |  |__| | "
echo  "    \__/  \__/     |__| | _|      |__| |__| \__|  \______| "
echo  " ___________    ____  _______ .______     ____    ____ .___________. __    __   __  .__   __.   _______ "
echo  "|   ____\   \  /   / |   ____||   _  \    \   \  /   / |           ||  |  |  | |  | |  \ |  |  /  _____|"
echo  "|  |__   \   \/   /  |  |__   |  |_)  |    \   \/   /   ---|  |---- |  |__|  | |  | |   \|  | |  |  __  "
echo  "|   __|   \      /   |   __|  |      /      \_    _/       |  |     |   __   | |  | |  .    | |  | |_ | "
echo  "|  |____   \    /    |  |____ |  |\  \----.   |  |         |  |     |  |  |  | |  | |  |\   | |  |__| | "
echo  "|_______|   \__/     |_______|| _|  ._____|   |__|         |__|     |__|  |__| |__| |__| \__|  \______| "
                                                                                                        
                                                           
                                                                                            
#If a lable can be defined it it will really help with the entries and loader.conf for bootctl
#Perhaps an MBR setup can leverage this?

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
 
    # Update live enviroment with latest packages from /etc/mirrorlist
        # Use reflector and download the best mirrorlist for the live enviroment
            # Tell pacstrap to download all required packages to new install at /mnt
                pacman -Syy
                
                    echo "Updating Mirrorlist"
                    reflector -c "GB" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist

echo  " ___  _   ___ ___ _____ ___    _   ___ "
echo  "| _ \/_\ / __/ __|_   _| _ \  /_\ | _ |"""
echo  "|  _/ _ \ (__\__ \ | | |   / / _ \|  _/"
echo  "|_|/_/ \_\___|___/ |_| |_|_\/_/ \_\_|  "
echo "Installing base system with development packages"


    pacstrap /mnt base base-devel dosfstools fakeroot gcc git linux linux-firmware sudo reflector pacman-contrib

                    
echo  " ___  _   ___ ___ _____ ___    _   ___ "
echo  "| _ \/_\ / __/ __|_   _| _ \  /_\ | _ |"""
echo  "|  _/ _ \ (__\__ \ | | |   / / _ \|  _/"
echo  "|_|/_/ \_\___|___/ |_| |_|_\/_/ \_\_|  "
echo "Installing System Daemons"


    pacstrap /mnt alsa-utils dhcpcd dnsmasq hostapd iwd man pulseaudio python-pyalsa xorg-server x11vnc xcompmgr xorg-xinit

                    
echo  " ___  _   ___ ___ _____ ___    _   ___ "
echo  "| _ \/_\ / __/ __|_   _| _ \  /_\ | _ |"""
echo  "|  _/ _ \ (__\__ \ | | |   / / _ \|  _/"
echo  "|_|/_/ \_\___|___/ |_| |_|_\/_/ \_\_|  "
echo "Installing System Utilties"


    pacstrap /mnt lxqt-qtplugin openbox tint2 zsh rsync pavucontrol-qt grub-customizer obconf-qt archlinux-xdg-menu

echo  " ___  _   ___ ___ _____ ___    _   ___ "
echo  "| _ \/_\ / __/ __|_   _| _ \  /_\ | _ |"""
echo  "|  _/ _ \ (__\__ \ | | |   / / _ \|  _/"
echo  "|_|/_/ \_\___|___/ |_| |_|_\/_/ \_\_|  "
echo "Installing CLI applications"


    pacstrap /mnt lshw nano reflector ranger sshfs wget htop brightnessctl hdparm lshw yt-dlp

echo  " ___  _   ___ ___ _____ ___    _   ___ "
echo  "| _ \/_\ / __/ __|_   _| _ \  /_\ | _ |"""
echo  "|  _/ _ \ (__\__ \ | | |   / / _ \|  _/"
echo  "|_|/_/ \_\___|___/ |_| |_|_\/_/ \_\_|  "
echo "Installing GUI applications"

    pacstrap /mnt chromium engrampa kwrite lxrandr pcmanfm-qt spectacle vlc feh kitty spectacle kdenlive gimp audacity

echo  " ___  _   ___ ___ _____ ___    _   ___ "
echo  "| _ \/_\ / __/ __|_   _| _ \  /_\ | _ |"""
echo  "|  _/ _ \ (__\__ \ | | |   / / _ \|  _/"
echo  "|_|/_/ \_\___|___/ |_| |_|_\/_/ \_\_|  "
echo "Installing SYN-Fonts"
    
    pacstrap /mnt terminus-font ttf-bitstream-vera

echo  " ___  _   ___ ___ _____ ___    _   ___ "
echo  "| _ \/_\ / __/ __|_   _| _ \  /_\ | _ |"""
echo  "|  _/ _ \ (__\__ \ | | |   / / _ \|  _/"
echo  "|_|/_/ \_\___|___/ |_| |_|_\/_/ \_\_|  "
echo "Installing SYN-RTOS Virtualization & Build set:"

    pacstrap /mnt git archiso git qemu-desktop edk2-ovmf libvirt virt-manager virt-viewer hexedit binwalk android-tools
                    

# This is just a requirement for boot functionality to exist on a physical disks
# Could this be improved rather than being as part of a shellscript
    
# Generate filesystem table with boot information in respect to UUID assignment 
echo  " _______  _______  __    _  _______  _______  _______  _______  _______ "
echo  "|       ||       ||  |  | ||       ||       ||       ||   _   ||  _    |"
echo  "|    ___||    ___||   |_| ||    ___||  _____||_     _||  |_|  || |_|   |"
echo  "|   | __ |   |___ |       ||   |___ | |_____   |   |  |       ||       |"
echo  "|   ||  ||    ___||  _    ||    ___||_____  |  |   |  |       ||  _   | "
echo  "|   |_| ||   |___ | | |   ||   |     _____| |  |   |  |   _   || |_|   |"
echo  "|_______||_______||_|  |__||___|    |_______|  |___|  |__| |__||_______|"

    genfstab -U /mnt >> /mnt/etc/fstab

echo  "  ____   ___ _____ _____ ___ _     _____ ____  "
echo  " |  _ \ / _ \_   _|  ___|_ _| |   | ____/ ___| "
echo  " | | | | | | || | | |_   | || |   |  _| \___ \ "
echo  " | |_| | |_| || | |  _|  | || |___| |___ ___) |"
echo  " |____/ \___/ |_| |_|   |___|_____|_____|____/ "
                                               
#Move the dotfiles to skel
    cp -Rv /root/Dotfiles/.* /mnt/etc/skel/
        
        
