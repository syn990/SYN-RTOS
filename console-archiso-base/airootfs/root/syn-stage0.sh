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


parted --script /dev/sda mklabel gpt mkpart primary fat32 1Mib 200Mib set 1 boot on
    parted --script /dev/sda mkpart primary ext4 201Mib 100%
        mkfs.vfat -F 32 /dev/sda1
        mkfs.ext4 -F /dev/sda2
            mount /dev/sda2 /mnt
            mkdir /mnt/boot/
            mount /dev/sda1 /mnt/boot
 
    # Update live enviroment with latest packages from /etc/mirrorlist
        # Use reflector and download the best mirrorlist for the live enviroment
            # Tell pacstrap to download all required packages to new install at /mnt
                pacman -Syy
                
                    echo "Updating Mirrorlist"
                    reflector -c "GB" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
                    
					echo "Installing base system with development packages"
                    			pacstrap /mnt base base-devel dosfstools fakeroot gcc git linux linux-firmware sudo reflector pacman-contrib
      
					echo "Installing System Daemons"
                    			pacstrap /mnt alsa-utils dhcpcd dnsmasq hostapd iwd pulseaudio python-pyalsa xorg-server x11vnc xcompmgr xorg-xinit
                    
					echo "Installing System Utilties"
					pacstrap /mnt lxqt-qtplugin openbox tint2 zsh rsync pavucontrol-qt grub-customizer obconf-qt archlinux-xdg-menu
					
                    			echo "Installing CLI applications"
					pacstrap /mnt lshw nano reflector ranger sshfs wget htop brightnessctl hdparm lshw yt-dlp
                
					echo "Installing GUI applications"
					pacstrap /mnt chromium engrampa kwrite lxrandr pcmanfm-qt spectacle vlc feh kitty spectacle kdenlive gimp audacity

					echo "Installing SYN-Fonts"
					pacstrap /mnt terminus-font ttf-bitstream-vera
                    
                    			echo "Installing SYN-RTOS Virtualization & Build set:"
                    			pacstrap /mnt git archiso git qemu-desktop edk2-ovmf libvirt virt-manager virt-viewer hexedit binwalk android-tools
                    
    
# This is just a requirement for boot functionality to exist on a physical disks
# Could this be improved rather than being as part of a shellscript
    
# Generate filesystem table with boot information in respect to UUID assignment 
    genfstab -U /mnt >> /mnt/etc/fstab
