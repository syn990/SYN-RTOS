# SYN-RTOS - Syntax990 Real-Time Operating System.
This Repo serves as a place to store and manage the source tree, as it's getting quite messy!

Currently there are two main scripts: (these will later be merged into a single script. It can't seem to run arch-chroot without stopping... this halts step two.) 

- syn-installer0.sh # part one -- Setup partitions, pacstrap packages and generate fstab.
- syn-installer1.sh # part two -- Customize configration files, create users and enable services.

The folders included are currenty not required at all for SYN-RTOS.

- network_scripts # Contains eno1-wlan0_bridge.sh which will provide an ethernet port with a route to the internet, assuming the wireless card has internet access. It also contains ip-configure.sh which will set an IP if you can't use DHCP and are lazy.
 - xibo-related # Contains junk archiso files used for an automated DSG player. This can eventually become it's own branch.
 

