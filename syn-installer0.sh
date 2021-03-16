#!/bin/sh
#Assumption - System has internet access and script is being run inside installer without chroot. All detected disks to be erased

# Setting up SYN-ARCHSO keyboard layout in TTY to UK
    loadkeys uk

# Setting up SYN-ARCHSO for NTP
    timedatectl set-ntp true

# Going completley nuclear and erasing disks with GPT partition and root partition
    parted --script /dev/sda mklabel gpt mkpart primary fat32 1Mib 200Mib set 1 boot on
    parted --script /dev/sda mkpart primary ext4 201Mib 100%
        mkfs.vfat -F /dev/sda1
        mkfs.ext4 -F /dev/sda2
            mount /dev/sda2 /mnt
            mkdir /mnt/boot/
            mount /dev/sda1 /mnt/boot
 
    # Update live enviroment with latest packages from /etc/mirrorlist
        # Use reflector and download the best mirrorlist for the live enviroment
            # Tell pacstrap to download all required packages to new install at /mnt
                pacman -Syy
                    reflector -c "GB" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
                        pacstrap /mnt alsa-utils base base-devel dhcpcd dnsmasq dosfstools fakeroot feh gcc git htop iwd kitty kwrite linux linux-firmware lshw lxqt-qtplugin lxrandr nano openbox pcmanfm-qt qutebrowser pulseaudio python-pyalsa ranger reflector rsync spectacle sshfs sudo tint2 vlc xf86-video-vesa xorg-bdftopcf xorg-docs xorg-fonts-100dpi xorg-fonts-75dpi xorg-fonts-encodings xorg-font-util xorg-iceauth xorg-mkfontscale xorg-server xorg-server-common xorg-server-devel xorg-server-xephyr xorg-server-xnest xorg-server-xvfb xorg-sessreg xorg-setxkbmap xorg-smproxy xorg-x11perf xorg-xauth xorg-xbacklight xorg-xcmsdb xorg-xcursorgen xorg-xdpyinfo xorg-xdriinfo xorg-xev xorg-xgamma xorg-xhost xorg-xinit xorg-xinput xorg-xkbcomp xorg-xkbevd xorg-xkbutils xorg-xkill xorg-xlsatoms xorg-xlsclients xorg-xmodmap xorg-xpr xorg-xprop xorg-xrandr xorg-xrdb xorg-xrefresh xorg-xset xorg-xsetroot xorg-xvinfo xorg-xwayland xorg-xwd xorg-xwininfo xorg-xwud xterm zsh terminus-font engrampa

# Generate filesystem table with boot information in respect to UUID assignment 
     genfstab -U /mnt >> /mnt/etc/fstab
