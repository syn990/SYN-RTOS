#!/bin/sh
# Assumption - chroot into /mnt after script 0

# Main script variables                                         
DEFAULT_USER990=syntax990
FINAL_HOSTNAME990=SYN-TESTBUILD


echo Setting username
echo Setting hostname
echo Setting hardware Clock
echo Updating package list using optimized mirror

    hwclock --systohc           # Run hwclock to generate /etc/adjtime
    pacman -Syy && reflector -c "GB" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
    
echo Generating /etc/locale.gen with LANG=en_GB.UTF-8
echo Generating Various System Variables

    rm /etc/locale.gen
    touch /etc/locale.gen       && echo 'en_GB.UTF-8 UTF-8'                     >> /etc/locale.gen
    locale-gen
    touch /etc/locale.conf      && echo 'LANG=en_GB.UTF-8'                      >> /etc/locale.conf
    touch /etc/vconsole.conf    && echo 'KEYMAP=uk'                             >> /etc/vconsole.conf
    touch /etc/hostname         && echo $FINAL_HOSTNAME990                      >> /etc/hostname
    touch /etc/issue            && echo 'Syntax990 RTOS (arch) \r (\l)'    >> /etc/issue

echo Forced Manual-Editi of sudoer file

EDITOR=nano visudo

echo Create $DEFAULT_USER990
echo Create $DEFAULT_USER990 Home Directory
echo Add $DEFAULT_USER990 To Wheel Group And Set Password
echo Force Password Reset For $DEFAULT_USER990
echo Copy Scripts To $DEFAULT_USER990 Account
echo Correct Permissions For $DEFAULT_USER990

    useradd -m -G wheel -s /bin/zsh $DEFAULT_USER990
      passwd $DEFAULT_USER990
        mkdir /home/$DEFAULT_USER990/SYNSTALL
        mkdir /home/$DEFAULT_USER990/.config
        mkdir /home/$DEFAULT_USER990/.local
            cp -r /root/SYNSTALL/scripts                    /home/$DEFAULT_USER990/SYNSTALL
            cp -r /root/SYNSTALL/DEFAULT_USER/.config       /home/$DEFAULT_USER990/.config
            cp -r /root/SYNSTALL/DEFAULT_USER/.local        /home/$DEFAULT_USER990/.local
            cp /root/SYNSTALL/DEFAULT_USER/.xinitrc         /home/$DEFAULT_USER990/.xinitrc
            cp /root/SYNSTALL/DEFAULT_USER/.zshrc           /home/$DEFAULT_USER990/.zshrc
      chown    $DEFAULT_USER990:$DEFAULT_USER990    -r      /home/$DEFAULT_USER990
        
echo Enabling DHCP client on boot               && systemctl enable dhcpcd.service
echo Enabling Wireless daemon on boot           && systemctl enable iwd.service    
echo BOOT-PARAMATER systemd-boot on boot        && bootctl --path=/boot install
