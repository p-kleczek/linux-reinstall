#! /bin/bash

PARTITION=sdd1
MOUNT_DIR=Seagate_2TB

MOUNT_DIR_ROOT_PATH=/media/$USER

# ------------------------------

MOUNT_DIR_PATH=$MOUNT_DIR_ROOT_PATH/$MOUNT_DIR

sudo mkdir $MOUNT_DIR_PATH
sudo mount -t ntfs /dev/$PARTITION $MOUNT_DIR_PATH
sudo chown -R $USER:$USER $MOUNT_DIR_PATH
sudo chmod 700 $MOUNT_DIR_PATH
