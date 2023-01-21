# SYN-RTOS = 'Syntax Real-Time Operating System'.

This is completely free and modifiable to the fullest extent and requires 'next to no effort to install'.

<sup><sub>Welcome to the SYN-RTOS repository! Inside, you will find all of the necessary materials to modify SYN-RTOS to your specific needs, package it into a convenient ISO for installation, and utilize a set of pre-written scripts and configurations. The standard template is based on a proof-of-concept system that has been in use since 2015, and some users have been utilizing similar systems as far back as 2005 with window managers like Fluxbox and Blackbox on minimal systems. This repository contains all necessary components and instructions to build, install and begin using SYN-RTOS." "The repository includes "SYN-RTOS-ARCHISOFILES", which is a profile for [archiso](https://wiki.archlinux.org/title/archiso) that allows you to implement any specific features you may need. At its core, the directory is a collection of text files (no executables) and serves as a template to create your own [Meta-Distribution](https://wiki.c2.com/?MetaDistribution) based on Arch Linux." The system uses [pacman](https://archlinux.org/packages/core/x86_64/pacman) to obtain packages on demand each time the installer is run, ensuring that the system is always fully up-to-date. Additionally, it is possible to copy pre-downloaded packages into the airootfs directory, modify the mirrorlist, and rebuild the ISO with the included local packages. This allows for even more flexibility and customization in the installation process. Finally template files are placed on the root directory, most importantly the template dotfiles placed in /etc/skel/ which are the basis for how the UI and system interactions operate. This can be adapted / ommitted / replaced with your intended functions. Effectivley SYN-RTOS is Arch Linux with my dotfiles and this build script.</sup></sub>

### SYN-RTOS 

(Scroll down to find "How do I get the X86_64 bootable ISO?")

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
Before running syn-stage0.sh, take the time to make any necessary modifications. Upon execution, the final script syn-stage1.sh will be copied over and ready for use, as demonstrated below.
```
# nano syn-stage1.sh # Edit the text file before running the script
# sh syn-stage1.sh   # Run the script
```
If no errors were encountered, it's safe to reboot into the new system. Note that DHCP may need to be manually enabled if it doesn't work out of the box, this is an issue that is currently being investigated, it is uncertain which package is causing the problem. However, it is possible that rebuilding the ISO later that month may yield different results.
```
# systemctl start dhcpcd.service
```

![Alt text](/Screenshots/syn-latest.png?raw=true)

### SYN-RTOS-V3 has these core principles that the resulting system must have.

- 1. The system on Idle must use less than 300MB of memory. Typical values range between 129MB
and 168MB. Perhaps just over 200MB with the graphical enviroment. The operating system must have very little memory overhead.

- 2. Be very kind to the CPU and do not ask for much on Idle.

- 3. SYN-RTOS prioritizes performance by using a tty login instead of a graphical login UI. This helps to minimize overhead and allows for a faster boot process without compromising efficiency. The decision to use a tty aligns with our principles and helps us avoid the need to maintain a login UI, manage sessions, support multiple accounts, and load graphical components during boot.

- 4. Be understood and modifiable to the fullest extent, so that SYN-RTOS is the bootloader for your own vision.

The design choices for SYN-RTOS may differ from the Arch Way or KISS principles. However, these choices have contributed to SYN-RTOS's current identity and success over the past 5 years. SYN-RTOS-V3 is the only version that fully integrates ISO and zero-touch deployment methods, which significantly improves development speed and testing. Please note that these design choices are specific to SYN-RTOS and may not be applicable to other systems.

## How do I get the X86_64 bootable ISO?

The raw ISO is not distributed. It shouldn't be. The source is in the scripts and you can produce an up-to-date live system on-the-spot. You can replace packages on-the-fly without transfer of any packages or manual traversal operations. The source is the respositories specified in pacman's mirrorlist and the packages specified in syn-stage0.sh. You can read every line and see for yourself. The archiso project, as well as all the developers for all packages included take the credit, as SYN-RTOS on a fudermental level is a custom archiso profile with dotfiles pre-included in the installation media.

https://wiki.archlinux.org/title/archiso#Build_the_ISO

- Arch Linux is officially supported, but it's not impossible to get archiso running on another system. I wouldn't know. You'll need the archiso package and it's depedencies to build the profile into a bootable ISO.

- Run this as root to produce an ISO. The profile being SYN-RTOS-ARCHISOFILES.

```
# mkarchiso -v -w /path/to/work_dir -o /path/to/out_dir /path/to/profile/
```

I can assure you that there are no rootkits or malicious code hidden in this repository. All of the materials are in a publicly visible, non-binary format and there are no obfuscated shell scripts. I am transparent in my work and there can be no accusations of nefarious activity. This repository is a reliable and trustworthy source for SYN-RTOS materials.

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
