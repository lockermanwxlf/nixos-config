#!/usr/bin/env bash
set -e

# Get hostname.
read -p "Enter hostname: " -r hostname

# Get password.
read -p "Enter password: " -s -r password
echo
read -p "Confirm password: " -s -r confirm_password
echo

if [ $password != $confirm_password ]; then
    echo "Passwords do not match."
    exit
fi

# Get device.
echo
lsblk --list --nodeps --paths -o name,model
read -p "Enter device: " -r device

# Partition device.
echo "Erasing $device."
sgdisk --zap-all $device
sleep 1
echo "Partitioning $device."
sgdisk --clear --new=1:0:+512MiB --typecode=1:ef00 --change-name=1:ESP \
               --new=2:0:0 --typecode=2:8300 --change-name=2:cryptsystem $device
sleep 1

# Encrypt device.
echo "Encrypting $device."
echo -n $password | cryptsetup luksFormat /dev/disk/by-partlabel/cryptsystem -
sleep 1
echo "Unlocking $device."
echo -n $password | cryptsetup luksOpen /dev/disk/by-partlabel/cryptsystem system -
sleep 1

# Format devices.
echo "Formatting devices."
mkfs.vfat -n EFI /dev/disk/by-partlabel/ESP
mkfs.ext4 -L system /dev/mapper/system
sleep 1

# Mount devices.
echo "Mounting devices."
mount /dev/disk/by-label/system /mnt
mkdir -p /mnt/boot
mount -o umask=077 /dev/disk/by-label/EFI /mnt/boot

nixos-generate-config --root /mnt
cp /home/nixos/step1_config.nix /mnt/etc/nixos/configuration.nix
echo "Creating user jake"
nixos-install --no-root-passwd
nixos-enter -c "su jake -c 'git clone https://github.com/lockermanwxlf/nixos-config ~/nixos-config'"
nixos-enter -c "su jake -c 'python ~/nixos-config/installation/generate_config.py $hostname ~/nixos-config'"
nixos-enter -c "su jake -c 'cp /etc/nixos/hardware-configuration.nix ~/nixos-config/hosts/$hostname'"
nixos-enter -c "su jake -c 'cd ~/nixos-config && git add --all'"
nixos-enter -c "rm -rf /etc/nixos"
nixos-enter -c "ln -s /home/jake/nixos-config /etc/nixos"
nixos-install --flake /mnt/home/jake/nixos-config/flake.nix#$hostname --no-root-passwd
echo "Finished."