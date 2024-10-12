#! /bin/bash

PARTITION=nvme0n1p6
MOUNT_DIR=data2

MOUNT_DIR_ROOT_PATH=/media/$USER

# ------------------------------

MOUNT_DIR_PATH=$MOUNT_DIR_ROOT_PATH/$MOUNT_DIR

# sudo mkdir $MOUNT_DIR_PATH
sudo mount /dev/$PARTITION $MOUNT_DIR_PATH
sudo chown -R $USER:$USER $MOUNT_DIR_PATH
sudo chmod 700 $MOUNT_DIR_PATH
