# DoomOS
# A single purpose OS for DOOM

# What is this about?
This project creates a Tiny Embedded Linux os which only purpose is to run 'DOOM'. 'Can it run DOOM'? has been a long going meme in the tech world. Running a classic shooter game on hardware or software or *things its not meant to. I decided to also join this meme and make a project arround it. Its a fully automatic script that downloads all the necesary files from the interwebs and compiles and prepares all the components. 
I originally got the idea from @shadlyd15 https://github.com/shadlyd15/DoomLinux. but i decided to make my own buildscript and project. If you are the original creator and want this repo to be removed (as i did not fully ask permission for using the idea, sorry!). Feel free to contact me at the given E-mail adres on the bottom anmd i will happily cooperate. 


The script only supports x86_64 hosts and not 32bit x86 hosts because 32bit support in the Linux world is kind of getting thrown out of the window and many projects and binaries only have 64bit support nowadays and i dont want to troubleshoot for days/weeks to add 32bit support so for now no 32bit cpus sadly. If you are a bit more advanced than me, feel free to add 32bit support yourself but please credit either me or the original creator for the idea @shadlyd15 if you plan on sharing it online. Also if you are modifying it and or reshare it (after you made changes or not) also credit either me or the original creator. 
The script's behaviour could be tweaked and or modified. In the script there are some variables like Kernel version, revision, busybox version, kernel mode (bios/uefi). I also provided some minimalistic configuration files for creating a really small Linux kernel of a few Megabytes. The configs are based on the tinyconfig option Linux comes with standard. And i provided a busybox config for compiling a 'just enough' busybox binary, also of a small size and with minimal bloat. Based on the allnoconfig. I also provided a small init script that boots fbdoom and mounts some Linux directories that are critical. Ofcourse you are free to tweak any of these to your likings! 

# What does it do and what gimmicks does this project have?
- Downloads all the required files
- Builds a really tiny Linux kernel
- Builds a small basic 'just enough' rootfs
- compiles all elements automatically
- Supports both UEFI and BIOS modes for backwards comaptibility with older BIOS systems (only must is that its a x86_64 cpu)
- If prompted 'y' will create a bootable iso for the target machine depending on what mode is selected (bios or uefi)
- Allows users to tweak bits
- comes with handy configs
- Provides precompiled kernel, filesystem and ISO images if you dont want to wait or if you dont want to build/compile all the elements. 
  
# Is it really as tiny as it seems?
yes! Because i made the kernel config from the tinyconfig option and busybox from the allnoconfig i managed to strip it down to the bare minimum but left in some amount of features. If you like you can strip it down even more but its already pretty tiny! The kernel image with the bios config is only 1.4-megabytes. The efi kernel is 1.8-megabytes. The rootfs is 3.3.-megabytes ins size and the DoomOs-bios iso is 24.1-Megabytes while the DoomOs-uefi iso is 24.4-megabytes. ofcourse this also depends on my grub type which seems to combine both versions (i386 and x86_64). So the ISo can be smaller. 

# Requirements
wget make gawk gcc bc bison flex unzip rsync mtools xorriso libelf-dev libssl-dev grub-common git build-essential grub-pc-bin

# Pictures
![IMG20250126234250](https://github.com/user-attachments/assets/8b941c3a-5872-4066-891b-85a55659d1c4)
![IMG20250126234228](https://github.com/user-attachments/assets/ea84ef36-5135-426b-adc4-4ce26bb02977)




# How to use?
1). Use git to clone the repo to your host system. '[https://github.com/RX309Electronics/DOOM_OS.git](https://github.com/RX309Electronics/DOOM_OS.git)'

2). Change directory into the folder. 'cd DOOM_OS'

3). Make the script executable. 'chmod +x build_doomos.sh'

4). Run the build script. 'bash build_doomos.sh' or './build_doomos.sh' (no need to be root)

5). Wait

6). Find the files in the output folder

# Disclaimer & Notice for the user
The iso has been only tested on my parent's and my own laptop and virtualbox and qemu. Because i used tinyconfig it creates te smallest Linux kernel image possible. While this is great, it might cause some isues on other systems that need specific drivers which the tinyconfig does not have. in that case due to the freedom of the project and the fact that the configfiles are easily accesible, you can tweak them to your hearts contend and add some drivers if the kernel does not work. Also i compiled busybox with only a few utilities and if you want more towards a fully functional embedded Linux distro, feel free to enable things in the busybox config file. 


# Problems/support
If you encounter any bugs/problems related to the script or want to contact me you can do so by either posting an issue in the issues field or by contacting me at my personal email adress @309electronics. I will try to react as soon as possible but do note that i am still a student who has school and work to do so i might not always have time, but i will try to be available as much as i can!
