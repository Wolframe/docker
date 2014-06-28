#!/bin/sh

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}
 
# Centos 6 (32-bit)

CHROOT_DIR=centos6-i386

mkdir $CHROOT_DIR

mkdir -p $CHROOT_DIR/var/lib/rpm

rpm -v --rebuilddb --root=`pwd`/$CHROOT_DIR

wget http://mirror.centos.org/centos/6.5/os/i386/Packages/centos-release-6-5.el6.centos.11.1.i686.rpm

rpm -v -i --root=`pwd`/$CHROOT_DIR --nodeps centos-release-6-5.el6.centos.11.1.i686.rpm 

rm -f centos-release-6-5.el6.centos.11.1.i686.rpm

wget http://mirror.centos.org/centos/6.5/os/i386/RPM-GPG-KEY-CentOS-6

rpm -v --root=`pwd`/$CHROOT_DIR --import RPM-GPG-KEY-CentOS-6 

rm RPM-GPG-KEY-CentOS-6

linux32 yum --installroot=`pwd`/$CHROOT_DIR install -y yum
linux32 yum --installroot=`pwd`/$CHROOT_DIR install -y coreutils procps net-tools wget

# rebuild the RPM database with the rpm inside the chroot
linux32 chroot $CHROOT_DIR /bin/rpm -v --rebuilddb

cp /etc/resolv.conf $CHROOT_DIR/etc/

systemd-nspawn --personality=x86 -D $CHROOT_DIR 
linux32 chroot $CHROOT_DIR

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/centos6-i386-base:6.5
docker tag wolframe/centos6-i386-base:6.5 wolframe/centos6-i386-base:latest

# Ubuntu 10.04

CHROOT_DIR=ubuntu1004-x86_64

mkdir $CHROOT_DIR

debootstrap --arch amd64 --verbose --variant=minbase lucid $CHROOT_DIR http://mirror.switch.ch/ftp/mirror/ubuntu/

# needed for package configuration
#chroot $CHROOT_DIR apt-get install -y --force-yes apt-utils

# needed for package GPG signature check
chroot $CHROOT_DIR apt-get install -y --force-yes gpgv

systemd-nspawn -D $CHROOT_DIR 
chroot $CHROOT_DIR

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/ubuntu1004-x86_64-base:10.04
docker tag wolframe/ubuntu1004-x86_64-base:10.04 wolframe/ubuntu1004-x86_64-base:latest

