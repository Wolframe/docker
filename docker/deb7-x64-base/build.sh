#!/bin/sh

# Debian 7 (64-bit)

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

CHROOT_DIR=deb7-x64

rm -rf $CHROOT_DIR

mkdir $CHROOT_DIR

debootstrap --arch amd64 --verbose --variant=minbase wheezy $CHROOT_DIR http://http.debian.net/debian/

docker rmi wolframe/deb7-x64-base:latest
docker rmi wolframe/deb7-x64-base:7.5

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/deb7-x64-base:7.5
docker tag wolframe/deb7-x64-base:7.5 wolframe/deb7-x64-base:latest
 
