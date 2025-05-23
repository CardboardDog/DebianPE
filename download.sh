#!/bin/bash

# LOAD CONFIG
source config.sh
# DOWNLOAD DEBIAN ISO
mkdir -p $LOCATION
wget -nc "${DEBIAN_URL}/${ISO_NAME}" -O "${LOCATION}/${ISO_NAME}"
echo $ISO_NAME >> "${LOCATION}/iso.txt"
# DOWNLOAD CHECKSUM AND PUBKEY
if [[ $DO_CHECKSUM == false ]]; then
    exit 0
fi
wget -nc "${DEBIAN_URL}/SHA512SUMS" -O "${LOCATION}/SHA512SUMS"
wget -nc https://people.debian.org/~danchev/debian-iso/check_debian_iso -O "${LOCATION}/check_iso"
chmod u+x "${LOCATION}/check_iso"
# VERIFY ISO
cd $LOCATION
SHA_OUT=`./check_iso SHA512SUMS $ISO_NAME`
echo $SHA_OUT
if [[ $SHA_OUT == *"Ok"* ]]; then
    exit 0
fi
exit 1
