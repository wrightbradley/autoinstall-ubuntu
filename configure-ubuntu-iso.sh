#!/bin/bash

ISO_VERSION="22.10"
ISO_FILENAME="ubuntu-${ISO_VERSION}-live-server-amd64.iso"

echo -e "\nInstalling necessary packages"
apt-get update && apt-get install --no-install-recommends -y p7zip-full p7zip-rar wget xorriso &&
  apt-get clean &&
  rm -rf /var/lib/apt/lists/*

cd /build || exit 1

echo -e "\nExtracting ISO"
7z -y x $ISO_FILENAME -osource-files

cd /build/source-files || exit 1

mv '[BOOT]' ../BOOT

echo -e "\nConfiguring grub.cfg"
cp /build/grub.cfg /build/source-files/boot/grub/grub.cfg

mkdir /build/source-files/server
cd /build/source-files/server || exit 1

touch meta-data

echo -e "\nConfiguring user-data"
cp /build/user-data /build/source-files/server/user-data

cd /build/source-files || exit 1

echo -e "\nCreating ISO image"
xorriso -as mkisofs -r \
  -V 'Ubuntu AUTO (EFIBIOS)' \
  -o ../ubuntu-${ISO_VERSION}-autoinstall.iso \
  --grub2-mbr ../BOOT/1-Boot-NoEmul.img \
  -partition_offset 16 \
  --mbr-force-bootable \
  -append_partition 2 28732ac11ff8d211ba4b00a0c93ec93b ../BOOT/2-Boot-NoEmul.img \
  -appended_part_as_gpt \
  -iso_mbr_part_type a2a0d0ebe5b9334487c068b6b72699c7 \
  -c '/boot.catalog' \
  -b '/boot/grub/i386-pc/eltorito.img' \
  -no-emul-boot -boot-load-size 4 -boot-info-table --grub2-boot-info \
  -eltorito-alt-boot \
  -e '--interval:appended_partition_2:::' \
  -no-emul-boot \
  .

echo -e "\nCustom ISO image created"
echo -e "\nPerforming Cleanup..."
cd /build || exit 1
rm -rf /build/BOOT
rm -rf /build/source-files
echo -e "\nDone. Exiting..."

exit
