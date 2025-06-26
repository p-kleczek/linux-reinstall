#! /bin/bash

# ------------------------------

PARTITION=sdb1  # Partition ID on which Seagate Expansion Drive 2TB is currently mounted (e.g., sdb1, sdd1, etc.)
# Check on which partition Seagate Expansion Drive 2TB is mounted, using:
# $ sudo lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL

MOUNT_DIR=Seagate_2TB

MOUNT_DIR_ROOT_PATH=/media/$USER

# ------------------------------

MOUNT_DIR_PATH=$MOUNT_DIR_ROOT_PATH/$MOUNT_DIR

sudo mkdir -p $MOUNT_DIR_PATH
sudo mount -t ntfs /dev/$PARTITION $MOUNT_DIR_PATH
sudo chown -R $USER:$USER $MOUNT_DIR_PATH
sudo chmod 700 $MOUNT_DIR_PATH
