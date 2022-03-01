#!/bin/bash
set -a
VMLINUZ=/boot/vmlinuz-lts
INITRAMFS=/boot/initramfs-lts
KERNEL_PARAMETERS="console=ttyS0 console=tty1 rootfstype=ext4 root=UUID=${UUID} init=/sbin/overlayRoot.sh ${KERNEL_PARAMETERS}"