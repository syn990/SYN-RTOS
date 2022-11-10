# SYN-RTOS = 'Syntax Real-Time Operating System'.

This repository's sole purpose is to contain the full build materials for SYN-RTOS-V3.

# SYN-RTOS-V1

SYN-RTOS-V1 in within itself has never existed, it is instead just a grey concept that has not yet been endoued on us.

# SYN-RTOS-V2

Version 2 existed as a bootstrapper of sorts, for a vanilla image of Arch Linux, requiring multiple inputs from a human as well as certain specfic un-documented requirements for reaching the resulting system. The 'git' package was neccessary to source the scripts and template dotfiles. These operations would instruct the live Arch Linux system to hopefully deploy a complete, reproducable system, live, without needing to deploy an image or physically clone data. The scripts were just about functional, design issues that made chroot impossible, manually needing to install git in a live enviroment was not always possible as the live disk may run out of storage.

Other methods such as transfering the build materials with a USB, mounting and dealing with additional filesystem operations were required. This would introduce inconsistencies with how partitioning would result. This was cumbersome and not sustainable given the potential changes from Arch and the increasing likleyhood my script would simply break.

The goal was at the time, to make a zero-touch, sane, modifiable meta-configuration of Arch Linux, however multiple projects with varying complexity have acheived this in a better way, and go against the spirit of Arch Linux to some degree. Now the latest 'arch-installer' package has to some degree done the heavy lifting, it's possible this Arch Linux endorsed feature may help.

SYN-RTOS-V2 ceases simply due to the lack of reproducability and poorly, or not at all in anyway meeting a zero-touch design. It would help reduce manual tasks but only to a varaible degree considering how bespoke hardware and build requirements are.

![Alt text](/Screenshots/SYN-RTOS-V2.1?raw=true)
![Alt text](/Screenshots/SYN-RTOS-V2.2?raw=true)

# SYN-RTOS-V3 

Version 3 instead is an ambitious attempt to utilise modern utilities provided by Arch Linux such as 'archiso', 'archinstaller', 'pacstrap', 'Openbox' + 'Tint2' + 'xcompmgr', curated dotfiles, custom scripts and images/icons/fonts, pertaining the graphical look-and-feel, the system shell and enviroment, as well as it's terminal/command dialect.

SYN-RTOS-V3 has these core principles that the resulting system must have.

- 1. The system on Idle must use less than 300MB of memory. Typical values range between 129MB
and 168MB. Perhaps just over 200MB with the graphical enviroment. The operating system must have very little memory overhead.

- 2. Be very kind to the CPU and do not ask for much on Idle.

- 3. Login directly to a tty. The graphical system will not be wrapped into an xorg-powered login UI. The user-centric nature of the system, and performance requirement to maintain the login UI, session management, multiple accounts, graphical components required during boot, are against principles 2 therefore not recreating an abstract login mechanism is a huge part of why this is possible.

- 4. Be understood and modifiable to the fullest extent, so that SYN-RTOS is the bootloader for your own vision.

These may deviate or not even be on the same abstract plain as The Arch Way or KISS principles. These are design choices for the sake of SYN-RTOS's current identity (and what it has successfully been for over 5 years). Only SYN-RTOS-V3 attempts to fully complete the ISO and zero-touch deployment methods. Further increasing development speed and testing.


![Alt text](/Screenshots/Editing_SYN-RTOS.PNG?raw=true)
![Alt text](/Screenshots/Openbox_Menu.PNG?raw=true)
![Alt text](/Screenshots/Pacman_Updates.PNG?raw=true)
![Alt text](/Screenshots/binwalk_and_analysis_on_ISO.PNG?raw=true)
![Alt text](/Screenshots/browsing_files_and_running_updates.PNG?raw=true)
![Alt text](/Screenshots/browsing_files_with_ranger.PNG?raw=true)
![Alt text](/Screenshots/browsing_web.PNG?raw=true)
![Alt text](/Screenshots/editing_scripts_and_browsing_files.PNG?raw=true)
![Alt text](/Screenshots/using_htop.PNG?raw=true)
