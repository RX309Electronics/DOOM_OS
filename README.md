# DoomOS
# A single purpose OS for DOOM

This project creates a Tiny Embedded Linux os which only purpose is to run 'DOOM'. 'Can it run DOOM'? has been a long going meme in the tech world. Running a classic shooter game on hardware or software or *things its not meant to. I decided to also join this meme and make a project arround it. Its a fully automatic script that downloads all the necesary files from the interwebs and compiles and prepares all the components. 
I originally got the idea from @shadlyd15 https://github.com/shadlyd15/DoomLinux. but i decided to make my own buildscript and project. If you are the original creator and want this repo to be removed (as i did not fully ask permission for using the idea, sorry!). Feel free to contact me at the given E-mail adres on the bottom anmd i will happily cooperate. 

The script only supports x86_64 hosts and not 32bit x86 hosts because 32bit support in the Linux world is kind of getting thrown out of the window and many projects and binaries only have 64bit support nowadays and i dont want to troubleshoot for days/weeks to add 32bit support so for now no 32bit cpus sadly. If you are a bit more advanced than me, feel free to add 32bit support yourself but please credit either me or the original creator for the idea @shadlyd15 if you plan on sharing it online. Also if you are modifying it and or reshare it (after you made changes or not) also credit either me or the original creator. 

The script's behaviour could be tweaked and or modified. In the script there are some variables like Kernel version, revision, busybox version, kernel mode (bios/uefi). I also provided some minimalistic configuration files for creating a really small Linux kernel of a few Megabytes. The configs are based on the tinyconfig option Linux comes with standard. And i provided a busybox config for compiling a 'just enough' busybox binary, also of a small size and with minimal bloat. Based on the allnoconfig. I also provided a small init script that boots fbdoom and mounts some Linux directories that are critical. Ofcourse you are free to tweak any of these to your likings!

# How to use?
1). Use git to clone the repo to your host system. 'git clone https://github.com/RX309Electronics/DoomOS.git'

2). Change directory into the folder. 'cd DoomOS'

3). Make the script executable. 'chmod +x build_doomos.sh'

4). Run the build script. 'bash build_doomos.sh' (no need to be root)

5). Wait

6). Find the files in the output folder


# Problems/support
If you encounter any bugs/problems related to the script or want to contact me you can do so by either posting an issue in the issues field or by contacting me at my personal email adress @309electronics. I will try to react as soon as possible but do note that i am still a student who has school and work to do so i might not always have time, but i will try to be available as much as i can!
