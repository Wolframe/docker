#!/bin/sh

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

# ArchLinux

CHROOT_DIR=arch

mkdir $CHROOT_DIR

pacstrap -c -d $CHROOT_DIR filesystem grep findutils coreutils glibc bash pacman procps-ng

sed -i 's/^SigLevel.*/SigLevel = Never/g' $CHROOT_DIR/etc/pacman.conf

systemd-nspawn -D $CHROOT_DIR
chroot $CHROOT_DIR

# Fedora

CHROOT_DIR=centos

mkdir $CHROOT_DIR

mkdir -p $CHROOT_DIR/var/lib/rpm

rpm -v --rebuilddb --root=`pwd`/$CHROOT_DIR

wget http://mirror.centos.org/centos/6.5/os/x86_64/Packages/centos-release-6-5.el6.centos.11.1.x86_64.rpm

rpm -v -i --root=`pwd`/$CHROOT_DIR --nodeps centos-release-6-5.el6.centos.11.1.x86_64.rpm 

rm -f centos-release-6-5.el6.centos.11.1.x86_64.rpm

wget http://mirror.centos.org/centos/6.5/os/x86_64/RPM-GPG-KEY-CentOS-6

rpm -v --root=`pwd`/$CHROOT_DIR --import RPM-GPG-KEY-CentOS-6 

rm RPM-GPG-KEY-CentOS-6

yum --installroot=`pwd`/$CHROOT_DIR install -y yum
yum --installroot=`pwd`/$CHROOT_DIR install -y coreutils procps net-tools wget

# rebuild the RPM database with the rpm inside the chroot
chroot $CHROOT_DIR /bin/rpm -v --rebuilddb

systemd-nspawn -D $CHROOT_DIR 
chroot $CHROOT_DIR

# Debian

CHROOT_DIR=debian

mkdir $CHROOT_DIR

debootstrap --verbose --variant=minbase wheezy $CHROOT_DIR http://http.debian.net/debian/

systemd-nspawn -D $CHROOT_DIR 
chroot $CHROOT_DIR

# Ubuntu

CHROOT_DIR=ubuntu

mkdir $CHROOT_DIR

debootstrap --verbose --variant=minbase lucid $CHROOT_DIR http://mirror.switch.ch/ftp/mirror/ubuntu/

# needed for package configuration
chroot $CHROOT_DIR apt-get install -y --force-yes apt-utils

# needed for package GPG signature check
chroot $CHROOT_DIR apt-get install -y --force-yes gpgv

systemd-nspawn -D $CHROOT_DIR 
chroot $CHROOT_DIR
