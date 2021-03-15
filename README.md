# SYN-RTOS - Syntax990 Real-Time Operating System.
This Repo serves as a place to store and manage the source tree, as it's getting quite messy!

Currently there are two main scripts: (these will later be merged into a single script. It can't seem to run arch-chroot without stopping... this halts step two.) 

- syn-installer0.sh # part one ~ Setup partitions, pacstrap packages and generate fstab.
- syn-installer1.sh # part two ~ Customize configration files, create users and enable services.

The folders included are currenty not required at all for SYN-RTOS.

- network_scripts ~

-- eno1-wlan0_bridge.sh     # will provide an ethernet port with a route to the internet. 
-- ip-configure.sh          # which will set an IP if you can't use DHCP and are lazy.

- xibo-related ~ 

Contains junk archiso files used for an automated Digital-signage player. This can eventually become it's own branch. Hopefully once the main and future xibo branches are complete it will provide a basic framework for creating other metadistrobutions
 

