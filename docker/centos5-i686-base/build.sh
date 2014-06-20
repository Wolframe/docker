#!/bin/sh

# Centos 5 (32-bit)

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

CHROOT_DIR=centos5-686

rm -rf $CHROOT_DIR

mkdir $CHROOT_DIR

mkdir -p $CHROOT_DIR/var/lib/rpm

rpm -v --rebuilddb --root=`pwd`/$CHROOT_DIR

wget http://mirror.centos.org/centos/5.10/os/i386/CentOS/centos-release-5-10.el5.centos.i386.rpm

rpm -v -i --root=`pwd`/$CHROOT_DIR --nodeps centos-release-5-10.el5.centos.i386.rpm

rm -f centos-release-5-10.el5.centos.i386.rpm

wget http://mirror.centos.org/centos/5.10/os/i386/RPM-GPG-KEY-CentOS-5

rpm -v --root=`pwd`/$CHROOT_DIR --import RPM-GPG-KEY-CentOS-5

rm RPM-GPG-KEY-CentOS-5

yum --installroot=`pwd`/$CHROOT_DIR install -y yum
yum --installroot=`pwd`/$CHROOT_DIR install -y coreutils procps net-tools wget db4 db4-utils

# dump the RPM database from version 5 outside the chroot
# and import it again in db4 format insite the chroot

rm -f $CHROOT_DIR/var/lib/rpm/__db.*
rm -f $CHROOT_DIR/var/lib/rpm/.*.lock
for i in $CHROOT_DIR/var/lib/rpm/*; do
	j=`basename $i`
	db_dump $i > $i.dmp
	mv $i $i.orig
	chroot $CHROOT_DIR db_load -f /var/lib/rpm/$j.dmp /var/lib/rpm/$j
	rm -f $i.dmp
	rm -f $i.orig
done

# rebuild the RPM database with the rpm inside the chroot
chroot $CHROOT_DIR /bin/rpm -v --rebuilddb

# yum requires /dev/urandom
mknod -m 0666 $CHROOT_DIR/dev/urandom c 1 9

cp /etc/resolv.conf $CHROOT_DIR/etc/

yum --installroot=`pwd`/$CHROOT_DIR remove -y db4-utils

docker rmi wolframe/centos5-i686-base:latest
docker rmi wolframe/centos5-i686-base:5.10

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/centos5-i686-base:5.10
docker tag wolframe/centos5-i686-base:5.10 wolframe/centos5-i686-base:latest
 
