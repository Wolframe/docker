#!/bin/sh

# Centos 7 Beta (64-bit)

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

CHROOT_DIR=rhel7-x64

rm -rf $CHROOT_DIR

mkdir $CHROOT_DIR

if test ! -f CentOS-7-20140625-x86_64-docker_01.img.tar.xz; then
	wget http://buildlogs.centos.org/centos/7/docker/CentOS-7-20140625-x86_64-docker_01.img.tar.xz
fi

cd $CHROOT_DIR
tar xf ../CentOS-7-20140625-x86_64-docker_01.img.tar.xz
cd ..

cp /etc/resolv.conf $CHROOT_DIR/etc/

docker rmi wolframe/rhel7-x64-base:latest
docker rmi wolframe/rhel7-x64-base:7.0

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/rhel7-x64-base:7.0
docker tag wolframe/rhel7-x64-base:7.0 wolframe/rhel7-x64-base:latest
 
