# DoomOS
# A single purpose OS for DOOM

This project creates a Tiny Embedded Linux os which only purpose is to run 'DOOM'. 'Can it run DOOM'? has been a long going meme in the tech world. Running a classic shooter game on hardware or software or *things its not meant to. I decided to also join this meme and make a project arround it. Its a fully automatic script that downloads all the necesary files from the interwebs and compiles and prepares all the components. 

This script downloads and builds a Linux kernel, configures it with a custom minimal-bloat configuration to make it as small and lightweight/fast as possible. With my provided config the kernel is just arround 1.4-Megabytes. 

The script will also build a minimal rootfs to go with it. The rootfs is based on busybox, a package that has many UNIX tools in an easy to use binary package. 

the script also downloads and builds fbdoom and the wad file for it. After everything is built it will assemble everything into a Doomfs.gz rootfilesystem and a kernel image. You can then later integaret the rootfs and kernel into an iso or just tes it with qemu. Make sure to use the 64bit qemu if you use my config. otherwise you can always edit the config files.

Feel free to inspect and or change the scripts and configs. You can compile any kernel you like by changing a few parameters and also any busybox version and doom wad by changing the urls. You can strip it down even more or increase functionality by changing the configs. You can switch to a 32bit kernel if you like and tweak almost all aspects to your liking. All is up to yourself!



If you have any questions or feedback, feel free to contact me at 309Electronics@gmail.com and i will try to respond as soon as possible. I might not always be available due to a busy schedule or even school but i will try my best to answer any questions or feedback. 

if you plan on using this project for your own private use, feel free to use it. If you plan on sharing it on the internet or social media, you are still free to use it, but make sure to credit me as one of these tags: '@309Electronics', '#309Electronics', 'By:309Electronics' and if possible put a link to my github page. I am a dutch student/hobbyist who likes tinkering and hobbying arround with electronics, tech, programing and embeded sytems and Linux and i am not really popular/known so if you could credit me i'd really apriciate it :)

Simply download the folder. Extract it (if necesary) and run the build_doomos.sh script. Grab some drink or snack and its (almost) done (if you have a fast pc). Make sure to have wget, git and allthe tools that you need for compiling linux and other stuff like: build-essential libncurses-dev bison flex libssl-dev libelf-dev etc etc etc. 




This only works on Linux hosts! I tested it on my host system which is debian12 based. I dont guarantee that it works on any distro but let me know if it works for you. 

1). Use git to clone the repo to your host system. 'git clone https://github.com/RX309Electronics/DoomOS.git'

2). Change directory into the folder. 'cd DoomOS'

3). Make the script executable. 'chmod +x build_doomos.sh'

4). Run the build script. 'bash build_doomos.sh' (no need to be root)

5). Wait

6). Find the files in the output folder
