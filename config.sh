#!/bin/bash

# CONFIG
VERSION="12.11.0"
ARCH="amd64"
DEBIAN_URL="https://cdimage.debian.org/debian-cd/current-live/${ARCH}/iso-hybrid"
LOCATION="iso"
DO_CHECKSUM=true 
BUILD="build"
DIST="dist"
ISO="debian-${VERSION}-${ARCH}-pe.iso"

# DONT TOUCH
ISO_NAME="debian-live-${VERSION}-${ARCH}-standard.iso"
