#!/bin/bash

source config.cfg

# ============================================================================
#               << INFORMACJE O SPRZĘCIE I SYSTEMIE OPERACYJNYM >>
# ============================================================================

# REF:  https://www.binarytides.com/linux-commands-hardware-info/

# The lscpu command reports information about the CPU and processing units. It does not have any further options or functionality.
lscpu

# List Hardware
lshw -short

# Hardware Information
hwinfo --short

# List PCI
lspci
# Filter out specific device information with grep.
# $ lspci -v | grep "VGA" -A 12

# List scsi devices
lsscsi

# List USB buses and device details
lsusb

# Inxi is a 10K line mega bash script that fetches hardware details from multiple different sources and commands on the system, and generates a beautiful looking report that non technical users can read easily.
inxi -Fx

# List block devices
lsblk

# Disk space of file systems
df -H

# Python df
# An improved df version written in python, that displays colored output that looks better than df
pydf

# The hdparm command gets information about sata devices like hard disks.
hdparm -i /dev/sda

# Network devices configuration
ip a
