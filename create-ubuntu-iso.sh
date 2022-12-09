#!/bin/bash

export ISO="https://releases.ubuntu.com/22.10/ubuntu-22.10-live-server-amd64.iso"
wget $ISO

# Create a directory named mnt and unpack the ISO contents locally.
export ORIG_ISO="ubuntu-22.10-live-server-amd64.iso"
mkdir mnt
mount -o loop $ORIG_ISO mnt

# Copy the existing boot file to /tmp/grub.cfg
cp --no-preserve=all mnt/boot/grub/grub.cfg /tmp/grub.cfg

# Modify /tmp/grub.cfg in the first section "Try or Install Ubuntu Server" to include 'autoinstall quiet' after 'linux /casper/vmlinuz.'
sed -i 's/linux	\/casper\/vmlinuz  ---/linux	\/casper\/vmlinuz autoinstall quiet ---/g' /tmp/grub.cfg

# The reduced timeout means that the boot menu prompt is only up for 1 second before moving forward with the 'autoinstall quiet'
sed -i 's/timeout=30/timeout=1/g' /tmp/grub.cfg

# Source modified from: https://discourse.ubuntu.com/t/cloud-init-and-the-live-server-installer/14597
# menuentry "Try or Install Ubuntu Server" {
#        set gfxpayload=keep
#        linux   /casper/vmlinuz autoinstall quiet ds=nocloud-net\;s=http://192.168.1.100/ ---
#        initrd  /casper/initrd
# }

# Setup livefs-editor
apt-get install xorriso squashfs-tools python3-debian gpg liblz4-tool python3-pip -y

git clone https://github.com/mwhudson/livefs-editor

cd livefs-editor/

python3 -m pip install .

# Copy the updated /tmp/grub.cfg file over using the --cp (copy) argument.
export MODDED_ISO="${ORIG_ISO::-4}-modded.iso"
livefs-edit ../$ORIG_ISO ../$MODDED_ISO --cp /tmp/grub.cfg new/iso/boot/grub/grub.cfg
