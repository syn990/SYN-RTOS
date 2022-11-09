#!/bin/sh
# Assumption - chroot into the new mounted root directory after syn-stage0.sh
# This script (syn-stage1.sh) needs to be placed on the resulting root filesystem and executed from within chroot
# Run this command: ( place the root directory for the new system, default is /mnt )
# arch-chroot /mnt

# Main script variables:
# These should be modified before running the script.

    DEFAULT_USER_990=syntax990                                          # This defines the username to be created in the useradd command
    FINAL_HOSTNAME_990=SYN-TESTBUILD                                    # This defines the hostname to be piped into /etc/hostname
    LOCALE_GEN_990="en_GB.UTF-8 UTF-8"                                  # This defines some locale stuff ?
    LOCALE_CONF_990="LANG=en_GB.UTF-8"                                  # This defines some locale stuff ?
    ZONE_INFO990=GB                                                     # This defines some locale stuff ?
    KEYMAP_990="KEYMAP=uk"                                              # This defines the terminal to use the UK key layout to /etc/vconsole.conf
    ISSUE_NAME_990="SYN-RTOS-V3 - Syntax Real-Time Operating System"    # This defines the OS name to be piped into /etc/issue
    SHELL_CHOICE_990=/bin/zsh                                           # This defines the default shell to use for the useradd command
    
# - Set the hardware clock to /etc/adjtime
# - Pacman to update the package lists
    
    hwclock --systohc
    pacman -Syy && reflector -c "GB" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist

        echo Set username to $DEFAULT_USER_990
        echo Set hostname to $FINAL_HOSTNAME_990
        echo Set various locale stuff = $LOCALE_GEN_990 $LOCALE_CONF_990 $ZONE_INFO990 $KEYMAP_990
        echo Set hardware Clock
        echo Reflector is generated an optimized mirror list to /etc/pacman.d/mirrorlist

# Generating Various System Variables

    rm /etc/locale.gen
    touch /etc/locale.gen       && echo $LOCALE_GEN_990                         >> /etc/locale.gen
    locale-gen
    touch /etc/locale.conf      && echo $LOCALE_CONF_990                        >> /etc/locale.conf
    touch /etc/vconsole.conf    && echo $KEYMAP_990                             >> /etc/vconsole.conf
    touch /etc/hostname         && echo $FINAL_HOSTNAME_990                     >> /etc/hostname
    touch /etc/issue            && echo $ISSUE_NAME_990                         >> /etc/issue
    ln -sf                      /usr/share/zoneinfo/$ZONE_INFO990               /etc/localtime

# Forced Manual Edit -- THIS NEEDS TO BE AUTOMATED WTF?

    EDITOR=nano visudo

# Create the user based on the variables, assign them a default shell then take ownership of home directory and files.

    useradd -m -G wheel -s $SHELL_CHOICE_990 $DEFAULT_USER_990              # Create the user, put them in the wheel group (for sudo permissions), then set their default shell.
    passwd $DEFAULT_USER_990                                                # Set the user's password
    chown $DEFAULT_USER_990:$DEFAULT_USER_990 -r /home/$DEFAULT_USER_990    # Let the user take ownership of their own files (or files may be owned by root!)
        
        
# Enable systemd services for DHCP, WiFi and setup the bootloader
    systemctl enable dhcpcd.service                     # Enable the DHCP client on boot
    systemctl enable iwd.service                        # Enable the Wireless daemon on boot
    bootctl --path=/boot install                        # Tell bootctl about the boot directory (is this even relevent now files are included in 1.root_filesystem_overlay ?)
