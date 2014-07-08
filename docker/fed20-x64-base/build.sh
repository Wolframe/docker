#!/bin/sh

# Fedora 20 (64-bit)

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

CHROOT_DIR=fed20-x64

rm -rf $CHROOT_DIR

mkdir $CHROOT_DIR

mkdir -p $CHROOT_DIR/var/lib/rpm

rpm -v --rebuilddb --root=`pwd`/$CHROOT_DIR

wget http://mirror.switch.ch/ftp/mirror/fedora/linux/releases/20/Fedora/x86_64/os/Packages/f/fedora-release-20-1.noarch.rpm

rpm -v -i --root=`pwd`/$CHROOT_DIR --nodeps fedora-release-20-1.noarch.rpm

rm -f fedora-release-20-1.noarch.rpm

wget -O RPM-GPG-KEY-fedora-20-primary https://fedoraproject.org/static/246110C1.txt

rpmkeys -v --root=`pwd`/$CHROOT_DIR --import RPM-GPG-KEY-fedora-20-primary

rm -f RPM-GPG-KEY-fedora-20-primary

yum --installroot=`pwd`/$CHROOT_DIR install -y yum
yum --installroot=`pwd`/$CHROOT_DIR install -y coreutils procps net-tools wget

# rebuild the RPM database with the rpm inside the chroot
chroot $CHROOT_DIR /bin/rpm -v --rebuilddb

cp /etc/resolv.conf $CHROOT_DIR/etc/

docker rmi wolframe/fed20-x64-base:latest
docker rmi wolframe/fed20-x64-base:20

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/fed20-x64-base:20
docker tag wolframe/fed20-x64-base:20 wolframe/fed20-x64-base:latest
 
