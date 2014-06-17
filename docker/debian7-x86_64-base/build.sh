#!/bin/sh

# Debian 7 (64-bit)

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

CHROOT_DIR=debian7-x86_64

rm -rf $CHROOT_DIR

mkdir $CHROOT_DIR

debootstrap --verbose --variant=minbase wheezy $CHROOT_DIR http://http.debian.net/debian/

docker rmi wolframe/debian7-x86_64-base:latest
docker rmi wolframe/debian7-x86_64-base:7.5

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/debian7-x86_64-base:7.5
docker tag wolframe/debian7-x86_64-base:7.5 wolframe/debian7-x86_64-base:latest
 
