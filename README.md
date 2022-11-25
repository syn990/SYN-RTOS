# SYN-RTOS = 'Syntax Real-Time Operating System'.

This is completely free and modifiable to the fullest extent and requires next to no effort to install. It allows you to implement any specific features you may need. At it's basics, the directory included "SYN-RTOS-ARCHISOFILES" is a profile for [archiso](https://wiki.archlinux.org/title/archiso)

Welcome. This repository contains the full build materials for SYN-RTOS, and this README.md contains the neccessary infomation to modify to the extent required, package into a convenient ISO for installation, and also have a pre-written set of scripts and configurations based on your needs. The standard template is a POC system I have been running since 2015, with some users having used a similar system way back in 05' on barebones systems with window managers like Fluxbox and Blackbox.

By design the installer is a collection of text files (no executables) and effectively provides a template to produce your own meta-distribution.

The system downloads packages on-demand each time the installer is run, enabling a fully up-to-date system each time. It is even possible to copy pre-downloaded packages into airootfs with a modified mirrorlist and rebuild the ISO with the packages included locally. 

### SYN-RTOS 
An ambitious attempt to utilise modern utilities provided by Arch Linux to quickly build a reproducable (Arch Linux derived) bootable ISO, using only offical mirrors and packages with   : 

 - [archiso](https://wiki.archlinux.org/title/archiso)   -- Required to build the ISO
 - [pacstrap](https://archlinux.org/packages/core/x86_64/pacman)  -- A feature of 'pacman' that allows installing packages to a seperate root directory
 - [openbox](http://openbox.org/wiki/Main_Page)                   -- The Window Manager
 - [tint2](https://gitlab.com/o9000/tint2)                      -- The panel, since Openbox and all other GUI's panel suck
 - [xcompmgr](https://github.com/freedesktop/xcompmgr)             -- An oldschool, limited compositor for drop-shadows and transparency
 - Curated Dotfiles                      (Designed to work with the default packages to apply the correct settings out-of-the-box)     
 - Custom Zero-Touch Install Scripts     (currently syn-stage0.sh and syn-stage1.sh which contain sane, modifiable variabes to easily deploy the system.
 - Images. Icons and Fonts                   (Pertaining the graphical look-and-feel, the system shell and enviroment, as well as it's terminal/command dialect.

```
# nano syn-stage0.sh
# sh syn-stage0.sh
```
Take the time to modify the script before running it. When run, the final script syn-stage1.sh is copied over and ready to be executed.

```
# nano syn-stage1.sh # Edit the text file before running the script
# sh syn-stage1.sh   # Run the script
```
Assuming there was no error it's safe to reboot into the new system.

You may have to enable DHCP if it does not work out the box (this is a new problem which I will eventually fix)

```
# systemctl start dhcpcd.service
```

![Alt text](/Screenshots/syn-latest.png?raw=true)

### SYN-RTOS-V3 has these core principles that the resulting system must have.

- 1. The system on Idle must use less than 300MB of memory. Typical values range between 129MB
and 168MB. Perhaps just over 200MB with the graphical enviroment. The operating system must have very little memory overhead.

- 2. Be very kind to the CPU and do not ask for much on Idle.

- 3. Login directly to a tty. The graphical system will not be wrapped into an xorg-powered login UI. The user-centric nature of the system, and performance requirement to maintain the login UI, session management, multiple accounts, graphical components required during boot, are against principles 2 therefore not recreating an abstract login mechanism is a huge part of why this is possible.

- 4. Be understood and modifiable to the fullest extent, so that SYN-RTOS is the bootloader for your own vision.

These may deviate or not even be on the same abstract plain as The Arch Way or KISS principles. These are design choices for the sake of SYN-RTOS's current identity (and what it has successfully been for over 5 years). Only SYN-RTOS-V3 attempts to fully complete the ISO and zero-touch deployment methods. Further increasing development speed and testing.

## How do I get the X86_64 bootable ISO?

The raw ISO is not distributed. It shouldn't be. The source is in the scripts and you can produce an up-to-date live system on-the-spot. You can replace packages on-the-fly without transfer of any packages or manual traversal operations. The source is the respositories specified in pacman's mirrorlist and the packages specified in syn-stage0.sh. You can read every line and see for yourself. The archiso project, as well as all the developers for all packages included take the credit, as SYN-RTOS on a fudermental level is a custom archiso profile with dotfiles pre-included in the installation media.

https://wiki.archlinux.org/title/archiso#Build_the_ISO

- Arch Linux is officially supported, but it's not impossible to get archiso running on another system. I wouldn't know. You'll need the archiso package and it's depedencies to build the profile into a bootable ISO.

- Run this as root to produce an ISO. The profile being SYN-RTOS-ARCHISOFILES.

```
# mkarchiso -v -w /path/to/work_dir -o /path/to/out_dir /path/to/profile/
```

It's impossible for me to embed a rootkit without it being visible on the public domain for all to see. None of what's on this repository is in a binary format and there is no dodgy code or obfuscated shell scripts. There can be no accusations of embedded rootkits or 1337 crackerness.

# Screenshots of system in use during various stages

![Alt text](/Screenshots/default-syn-theme.png?raw=true)
![Alt text](/Screenshots/green-syn-theme.png?raw=true)
![Alt text](/Screenshots/red-syn-theme.png?raw=true)
![Alt text](/Screenshots/reddown-syn-theme.png?raw=true)
![Alt text](/Screenshots/Openbox_Menu.PNG?raw=true)
![Alt text](/Screenshots/Pacman_Updates.PNG?raw=true)
![Alt text](/Screenshots/binwalk_and_analysis_on_ISO.PNG?raw=true)
![Alt text](/Screenshots/browsing_files_and_running_updates.PNG?raw=true)
![Alt text](/Screenshots/browsing_files_with_ranger.PNG?raw=true)
![Alt text](/Screenshots/browsing_web.PNG?raw=true)
![Alt text](/Screenshots/editing_scripts_and_browsing_files.PNG?raw=true)
![Alt text](/Screenshots/using_htop.PNG?raw=true)

# SYN-RTOS-V1

SYN-RTOS-V1 in within itself has never existed, it is instead just a grey concept that has not yet been endoued on us. Only a few reminants such as the MBR 'splash.png' and some scripts have survived and been uploaded.

![Alt text](/Screenshots/syn-rtos-v1.PNG?raw=true)

# SYN-RTOS-V2

Version 2 existed as a bootstrapper of sorts, for a vanilla image of Arch Linux, requiring multiple inputs from a human as well as certain specfic un-documented requirements for reaching the resulting system. The 'git' package was neccessary to source the scripts and template dotfiles. These operations would instruct the live Arch Linux system to hopefully deploy a complete, reproducable system, live, without needing to deploy an image or physically clone data. The scripts were just about functional, design issues that made chroot impossible, manually needing to install git in a live enviroment was not always possible as the live disk may run out of storage.

Other methods such as transfering the build materials with a USB, mounting and dealing with additional filesystem operations were required. This would introduce inconsistencies with how partitioning would result. This was cumbersome and not sustainable given the potential changes from Arch and the increasing likleyhood my script would simply break.

The goal was at the time, to make a zero-touch, sane, modifiable meta-configuration of Arch Linux, however multiple projects with varying complexity have acheived this in a better way, and go against the spirit of Arch Linux to some degree. Now the latest 'arch-installer' package has to some degree done the heavy lifting, it's possible this Arch Linux endorsed feature may help.

SYN-RTOS-V2 ceases simply due to the lack of reproducability and poorly, or not at all in anyway meeting a zero-touch design. It would help reduce manual tasks but only to a varaible degree considering how bespoke hardware and build requirements are.

![Alt text](/Screenshots/syn-rtos-v2-1.PNG?raw=true)
![Alt text](/Screenshots/syn-rtos-v2-2.PNG?raw=true)
