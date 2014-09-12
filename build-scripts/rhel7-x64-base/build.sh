#!/bin/sh

# Centos 7 (64-bit)

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

CHROOT_DIR=rhel7-x64

rm -rf $CHROOT_DIR

mkdir $CHROOT_DIR

mkdir -p $CHROOT_DIR/var/lib/rpm

rpm -v --rebuilddb --root=`pwd`/$CHROOT_DIR

wget http://mirror.centos.org/centos/7.0.1406/os/x86_64/Packages/centos-release-7-0.1406.el7.centos.2.3.x86_64.rpm

rpm -v -i --root=`pwd`/$CHROOT_DIR --nodeps centos-release-7-0.1406.el7.centos.2.3.x86_64.rpm

rm -f centos-release-7-0.1406.el7.centos.2.3.x86_64.rpm

wget http://mirror.centos.org/centos/7.0.1406/os/x86_64/RPM-GPG-KEY-CentOS-7

rpm -v --root=`pwd`/$CHROOT_DIR --import RPM-GPG-KEY-CentOS-7

rm RPM-GPG-KEY-CentOS-7

yum --installroot=`pwd`/$CHROOT_DIR install -y yum
yum --installroot=`pwd`/$CHROOT_DIR install -y coreutils procps net-tools wget

# rebuild the RPM database with the rpm inside the chroot
chroot $CHROOT_DIR /bin/rpm -v --rebuilddb

cp /etc/resolv.conf $CHROOT_DIR/etc/

docker rmi wolframe/rhel7-x64-base:latest
docker rmi wolframe/rhel7-x64-base:7.0.1406

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/rhel7-x64-base:7.0.1406
docker tag wolframe/rhel7-x64-base:7.0.1406 wolframe/rhel7-x64-base:latest
 
