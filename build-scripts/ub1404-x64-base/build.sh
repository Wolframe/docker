#!/bin/sh

# Ubuntu 14.04 (64-bit)

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

CHROOT_DIR=ub1404-x64

rm -rf $CHROOT_DIR

mkdir $CHROOT_DIR

debootstrap --arch amd64 --verbose --variant=minbase trusty $CHROOT_DIR http://mirror.switch.ch/ftp/mirror/ubuntu/

# needed for package configuration
chroot $CHROOT_DIR apt-get install -y --force-yes apt-utils

# needed for package GPG signature check
chroot $CHROOT_DIR apt-get install -y --force-yes gpgv

# add universe to apt source list
sed -i 's/trusty main$/trusty main universe/g' $CHROOT_DIR/etc/apt/sources.list
chroot $CHROOT_DIR apt-get update

# install some editors
chroot $CHROOT_DIR apt-get -y --force-yes install vim jupp

docker rmi wolframe/ub1404-x64-base:latest
docker rmi wolframe/ub1404-x64-base:14.04

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/ub1404-x64-base:14.04
docker tag wolframe/ub1404-x64-base:14.04 wolframe/ub1404-x64-base:latest
 

