#!/bin/bash

# LOAD CONFIG
source config.sh
# EXTRACT
mkdir -p $BUILD
mkdir -p $DIST
xorriso -osirrox on -indev "${LOCATION}/${ISO_NAME}" -extract /isolinux "${BUILD}/isolinux"
xorriso -osirrox on -indev "${LOCATION}/${ISO_NAME}" -extract /boot/ "${BUILD}/boot"
chmod -R u+w $BUILD
# PATCH
rm "${BUILD}/isolinux/live.cfg"
cp isolinux.cfg "${BUILD}/isolinux/live.cfg"
perl -pi -e "s/\[ARCH\]/${ARCH}/g" "${BUILD}/isolinux/live.cfg"
rm "${BUILD}/boot/grub/grub.cfg"
cp grub.cfg "${BUILD}/boot/grub/grub.cfg"
perl -pi -e "s/\[ARCH\]/${ARCH}/g" "${BUILD}/boot/grub/grub.cfg"
rm "${BUILD}/isolinux/isolinux.bin"
dd if=/dev/zero of="${BUILD}/ext.img" bs=2048 count=1k
mkfs.ext4 -F "${BUILD}/ext.img"
# REBUILD
echo "${DIST}/${ISO}"
xorriso \
	-indev "${LOCATION}/${ISO_NAME}" \
	-outdev "${DIST}/${ISO}" \
	\
	-map "${BUILD}/isolinux" /isolinux \
	-map "${BUILD}/boot/" /boot \
	\
	-boot_image any replay \
	\
	-compliance no_emul_toc \
	-padding included \
	-append_partition 3 0x83 "${BUILD}/ext.img" \

# check this out: https://wiki.debian.org/RepackBootableISO
