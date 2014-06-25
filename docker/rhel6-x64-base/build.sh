#!/bin/sh

# Centos 6 (64-bit)

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

CHROOT_DIR=rhel6-x64

rm -rf $CHROOT_DIR

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

cp /etc/resolv.conf $CHROOT_DIR/etc/

docker rmi wolframe/rhel6-x64-base:latest
docker rmi wolframe/rhel6-x64-base:6.5

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/rhel6-x64-base:6.5
docker tag wolframe/rhel6-x64-base:6.5 wolframe/rhel6-x64-base:latest
 
