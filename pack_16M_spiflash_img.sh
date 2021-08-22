#!/bin/bash

# env
UBOOT_SOURCE_TREE=./../u-boot
LINUX_SOURCE_TREE=./../linux
BUILDROOT_SOURCE_TREE=

# source file location, should compile first.
UBOOT_SPL_IMG=$UBOOT_SOURCE_TREE/u-boot-sunxi-with-spl.bin
DTB_IMG=$UBOOT_SOURCE_TREE/arch/arm/dts/suniv-f1c100s-licheepi-nano.dtb
LINUX_IMG=$LINUX_SOURCE_TREE/arch/arm/boot/zImage
ROOTFS_IMG=$BUILDROOT_SOURCE_TREE/

# name of firmware output
OUTPUT_BIN=./spiflash_16M_img.bin

# create a new empty file size 16M
dd conv=notrunc if=/dev/zero of=$OUTPUT_BIN bs=1M count=16

# write u-boot_xx.bin to pos 0
dd conv=notrunc if=$UBOOT_SPL_IMG of=$OUTPUT_BIN

# write dtb to pos 0x800
dd conv=notrunc if=$DTB_IMG of=$OUTPUT_BIN seek=$((0x800))

#write zImage to pos 0x888
dd conv=notrunc if=$LINUX_IMG of=$OUTPUT_BIN seek=$((0x888))

#write rootfs.jffs2 to pos 0x2000(8M) the end ofzImage is around pos 6M.
#dd conv=notrunc if= of=$OUTPUT_BIN seek=$((0x888))


