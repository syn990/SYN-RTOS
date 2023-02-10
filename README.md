# SYN-RTOS = 'Syntax Real-Time Operating System'.

SYN-RTOS is a specialized operating system built using the ArchISO project, designed to provide advanced users with an efficient and customizable system. It offers by default a comprehensive list of modifications and additions aimed at improving performance and functionality, making it an ideal starting point for users who want to learn Arch Linux and system administration.

The project provides the necessary files and build scripts to construct a live system, streamlining the setup of a customized environment and leveraging the Arch Linux infrastructure, documentation, and development as a stable base. The ISO, combined with the provided 'profile' for Archiso, will build the latest system image according to the mirrors detected by Reflector.

While this system is not for the faint of heart and requires at an understanding of or willingness to use Linux, it is a well-constructed template that provides a strong foundation for users to build their own system and learn Arch Linux from scratch. By using SYN-RTOS as a starting point, users can quickly start their journey towards becoming proficient in Arch Linux and system administration.

Please note that the use of this system still requires a certain level of technical skill and understanding, and comes with a warning to "Use at your own risk".

In other words: 

This version of Arch Linux is designed with a focus on customization and documentation, serving as a reference for others looking to set up their own system. The clear documentation provides step-by-step instructions for setup and configuration, and the implementation is fully modifiable to meet specific needs. With this reference, individuals can work backwards to create their own customized Arch Linux projects that align with their personal goals and requirements.

# How does it look (more photos at the end)
![Alt text](/Screenshots/syn-latest.png?raw=true)

The user interface of the system is designed to be both minimal and customizable, with a focus on consistency in font, color, and theme. Three main themes are pre-included and can be easily modified to suit individual preferences. The window manager Openbox has been configured using its own dot files, and the taskbar tint2 has also been customized to fit the overall aesthetic of the UI. Compositing is enabled using xcompmgr to provide a smooth and visually appealing experience.

The UI is designed to be lightweight, providing maximum pixel real estate for the user, and it is also highly extensible and replaceable. Rather than relying on a monolithic desktop environment, the system is built from a loose collection of software components that can be easily swapped out and customized as needed. This modular approach ensures that the system remains minimal in its footprint and provides maximum flexibility for the user. Overall, the UI intends to provide a consistent and aesthetically pleasing experience, while still allowing for customization and flexibility.

# How do I get the ISO?

Inside this reposity exists a directory called SYN-RTOS. This directory is a profile that can be interpreted by Archiso and will reproduce the ISO as defined by the profile. The intended nature of this design is to ensure a fresh live system build on the spot and with the profile being modifiable to what is useful / required / intended.

This repository contains a directory named SYN-RTOS, which serves as a custom profile for Archiso. This profile is used to build a live ISO image that is tailored to specific requirements and configurations. The custom profile provides a convenient way to create a fresh live system with the desired properties and configurations, without the need for manual configuration each time. It is important to note that the SYN-RTOS profile only contributes to the creation of the live ISO image and does not affect the final installed operating system. Once the live ISO image is used to install the operating system, the custom profile has fulfilled its purpose and will not have any further influence on the installed system. Nevertheless, the SYN-RTOS profile can still be modified and re-used to create new live ISO images with different configurations as needed.

The command mkarchiso is used to build an Arch Linux live ISO image. The various options passed to mkarchiso configure the build process and specify the output file.

```
# mkarchiso -v -w /path/to/work_dir -o /path/to/out_dir /path/to/profile/
```
> The mkarchiso command here has 4 options: -v for verbose mode, -w for working directory, -o for output directory, and the profile directory for which to build the live ISO image to.

The custom profile called SYN-RTOS will be used to build the live ISO image. The live ISO image built using this custom profile will have the properties and configuration defined in the SYN-RTOS profile. The purpose of building a custom profile is to create a live ISO image that is tailored to specific needs, such as running a specific application or providing a customized environment.

## syn-stage0.sh

In this repository:           /SYN-RTOS/SYN-RTOS-ARCHISOFILES/airootfs/root/syn-stage0.sh

In the booted enviroment:     /root/syn-stage0.sh

This is a script for setting up the system, with a focus on customization and documentation. The script provides a clear set of instructions for setting up and configuring the system, as well as a list of packages that can be installed. The packages are grouped into different categories, such as base packages, system utilities, control tools, window managers, command-line tools, graphical user interface tools, fonts, extra packages for command-line use, extra packages for graphical use, and extra packages for virtual machines. The script uses a single pacstrap command to install all the packages, allowing for an accurate prediction of total package size during installation. Users can add their own packages to the script by including them after the $SYNSTALL variable. The script begins by updating the mirror list and securing the keyring, then proceeds to install the specified packages to the resulting system. It is intended to be modified before executing the install inside the live enviroment.

The script uses the parted utility to create two partitions on the defined disk, a fat32 partition for the boot files, and an ext4 partition for the root file system. The script then formats these partitions using the mkfs command. It's intended for a UEFI/GPT install. You can modify the partitions according to how the drives identiy. These can be checked using lsblk which is included in the 'profile'.

Generation of the filesystem table with boot information in respect to UUID assignment and copying the materials from the 1.root_filesystem_overlay to the result system root directory. These contain important confiuration files that are armed on the next script. 'genfstab' is used to generate the filesystem table and then it is copied to the /mnt/etc/fstab directory. The materials from the /root/SYN-RTOS-V3/1.root_filesystem_overlay/ directory are then copied to the new root directory.

Once syn-stage0.sh is completed, the user must arch-chroot into the new system to continue the build process. To do this, they must run the following command: 
```
arch-chroot /mnt.
```
Once they are in the new system, they must run the syn-stage1.sh script to continue the build process. It is important to make any necessary amendments to the variables in the script before running it to ensure that the intended result system is built.

Overall, stage0.sh is responsible for creating the necessary file systems, mounting the partitions, performing the pacstrap, generating the fstab, and copying the necessary files to the new root file system.

![Alt text](/Screenshots/default-syn-theme.png?raw=true)
![Alt text](/Screenshots/green-syn-theme.png?raw=true)
![Alt text](/Screenshots/red-syn-theme.png?raw=true)
![Alt text](/Screenshots/reddown-syn-theme.png?raw=true)
![Alt text](/Screenshots/Openbox_Menu.PNG?raw=true)
![Alt text](/Screenshots/Pacman_Updates.PNG?raw=true)
