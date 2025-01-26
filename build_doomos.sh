#!/bin/bash
clear &

# Some parameters for setting Linux kernel version
LINUX_REVISION="6.x" # Defines the Linux kernel revision
ACTUAL_LINUX_VERSION="6.6.9" # Defines the actual Kernel version
BUSYBOX_VERSION="1.37.0" # Defines the version of busybox used
KERNEL_MODE="uefi" # Compile the kernel for either Bios or (U)EFI mode

# The download URL for the Linux kernel and BUSYBOX
LINUX_URL="https://www.kernel.org/pub/linux/kernel/v$LINUX_REVISION/linux-$ACTUAL_LINUX_VERSION.tar.xz"
BUSYBOX_URL="https://www.busybox.net/downloads/busybox-$BUSYBOX_VERSION.tar.bz2"
FBDOOM_URL="https://github.com/maximevince/fbDOOM/archive/refs/heads/master.zip"
DOOM_WAD_URL="https://distro.ibiblio.org/slitaz/sources/packages/d/doom1.wad"

# Check if the given Linux kernel version is valid
echo -e "Checking if Linux version: $ACTUAL_LINUX_VERSION is valid and exists...\n"

# Use curl to check if the Linux URL and version is valid
curl --head --silent --fail "$LINUX_URL" > /dev/null
if [ $? -eq 0 ]; then
  echo "Linux-$ACTUAL_LINUX_VERSION exists and is valid!"
else
  echo "Linux-$ACTUAL_LINUX_VERSION does not exist. Please check if your revision number is valid or append a valid kernel version. Look on kernel.org for available versions"
  exit 1
fi

sleep 1

# Check if the Given Busybox version is valid
echo -e "Checking if Busybox version: $BUSYBOX_VERSION is valid and exist...\n"

# Use curl to check if the Busybox URL and version is valid
curl --head --silent --fail "$BUSYBOX_URL" > /dev/null
if [ $? -eq 0 ]; then
  echo "Busybox-$BUSYBOX_VERSION exists and is valid!"
else
  echo "Busybox-$BUSYBOX_VERSION does not exist. Please append a correct version. Look on busybox.org for available versions"
  exit 1
fi

# Check if the files already exist in the directory before downloading. If yes skip download process to save time
if [ -f "linux-$ACTUAL_LINUX_VERSION.tar.xz" ]; then
  echo "Linux-$ACTUAL_LINUX_VERSION.tar.xz already exists in the directory. Skipping download!"
else
  echo "Downloading Linux-$ACTUAL_LINUX_VERSION..."
  wget "$LINUX_URL"
  sleep 1
fi

if [ -f "busybox-$BUSYBOX_VERSION.tar.bz2" ]; then
  echo "Busybox-$BUSYBOX_VERSION.tar.bz2 already exists in the directory. Skipping download!"
else
  echo "Downloading Busybox-$BUSYBOX_VERSION..."
  wget "$BUSYBOX_URL"
  sleep 1
fi

if [ -f "master.zip" ]; then
  echo "fbDOOM already exists in directory. Skipping download!"
else
  echo "Downloading fbDOOM..."
  wget "$FBDOOM_URL"
  sleep 1
fi

if [ -f "doom1.wad" ]; then
  echo "doom1.wad already exists in directory. Skipping download!"
else
  echo "Downloading doom1.wad..."
  wget "$DOOM_WAD_URL"
  sleep 1
fi

echo "Download completed!"
sleep 1
clear
sleep 1

# Extract Linux and Busybox and fbDOOM
echo "Extracting Linux-$ACTUAL_LINUX_VERSION..."
tar -xf linux-$ACTUAL_LINUX_VERSION.tar.xz
sleep 1
echo "Extracting Busybox-$BUSYBOX_VERSION..."
tar -xf busybox-$BUSYBOX_VERSION.tar.bz2
sleep 1
echo "Extracting fbDOOM..."
unzip master.zip

echo "Done!"
mkdir output
sleep 1

# Configure Linux
cd linux-$ACTUAL_LINUX_VERSION
echo "Configuring the kernel..."
sleep 1

if [ "$KERNEL_MODE" = "bios" ]; then
  echo "BIOS mode configured! Compiling kernel for target x86_64 BIOS"
  cp ../configs/DoomOs_kernel_64bit_bios.config .config
else
  echo "(U)EFI mode configured! Compiling kernel for target x86_64 UEFI"
  cp ../configs/DoomOs_kernel_64bit_efi.config .config
fi
# Build Linux
echo "Done! Compiling the kernel..."
make -j $(nproc)
if [ "$KERNEL_MODE" = "bios" ]; then
  cp arch/x86/boot/bzImage ../output
else
  cp arch/x86/boot/bzImage ../output/bzImage-efi
fi

echo "Done!"
sleep 1
clear
sleep 2

# Compile fbDOOM
echo "Compiling fbDOOM..."
sleep 1
cd ../fbDOOM-master
cd fbdoom
sed -i "s|CFLAGS+=-ggdb3 -Os|CFLAGS+=-ggdb3 -Os -static|" Makefile
sed -i "s|ifneq (\$(NOSDL),1)|ifeq (\$(LINK_SDL),1)|" Makefile
make -j $(nproc)
cp fbdoom ../../output

echo "Done!"
sleep 1

# Configure and compile busybox static
cd ../../busybox-$BUSYBOX_VERSION
echo "Compiling busybox static..."
sleep 1
cp ../configs/busybox.config .config
make -j $(nproc)
make busybox install
echo "Done! Copying files to busybox directory..."
sleep 1
mkdir _install/proc
cp ../output/fbdoom _install/bin
cp ../doom1.wad _install/bin
cp ../initscript _install/init
chmod +x _install/init

echo "Done!"
sleep 1
clear
sleep 1

# Install kernel modules into the rootfs and finish buildprocess
cd ../linux-$ACTUAL_LINUX_VERSION
echo "Installing the kernel modules"
make modules_install INSTALL_MOD_PATH=../busybox-$BUSYBOX_VERSION/_install
echo "Generating filesystem image Doomfs.gz..."
cd ../busybox-$BUSYBOX_VERSION/_install
find . | cpio -R root:root -H newc -o | gzip > ../../output/Doomfs.gz
echo "Doomfs.gz ready!"

cd ../../output

echo "Do you want to create a bootable ISO? (y/n)"
read CREATE_ISO

if [ "$CREATE_ISO" = "y" ]; then
  echo "Creating ISO file..."
  mkdir iso
  mkdir iso/boot
  mkdir iso/boot/grub
  cp Doomfs.gz iso/boot
  if [ "$KERNEL_MODE" = "bios" ]; then
    cp bzImage iso/boot
    cp ../configs/grub-bios.config iso/boot/grub/grub.cfg
    sleep 1
    grub-mkrescue -o DoomOS-bios.iso iso
  else
    cp bzImage-efi iso/boot
    cp ../configs/grub-efi.config iso/boot/grub/grub.cfg
    sleep 1
    grub-mkrescue -o DoomOS-uefi.iso iso
  fi
  echo "ISO created successfully!"
fi
echo "Buildprocess finished!"

