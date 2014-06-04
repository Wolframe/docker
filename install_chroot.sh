#!/bin/sh

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

# ArchLinux

CHROOT_DIR=arch

mkdir $CHROOT_DIR

pacstrap -c -d $CHROOT_DIR filesystem grep findutils coreutils glibc bash pacman procps-ng

sed -i 's/^SigLevel.*/SigLevel = Never/g' $CHROOT_DIR/etc/pacman.conf

systemd-nspawn -D $CHROOT_DIR
chroot $CHROOT_DIR

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/archlinux-64-base:201406

# Centos

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

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/centos-64-base:6.5

# Debian

CHROOT_DIR=debian

mkdir $CHROOT_DIR

debootstrap --verbose --variant=minbase wheezy $CHROOT_DIR http://http.debian.net/debian/

systemd-nspawn -D $CHROOT_DIR 
chroot $CHROOT_DIR

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/debian-64-base:7.5

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

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/ubuntu-lucid-64-base:10.04

# Slackware

CHROOT_DIR=slackware

# make a mirror of packages, actually better would be to repect here 'slackware_packages' too)
for set in a ap l n; do
	wget -nv -r -l1 --no-parent -A txz http://mirror.netcologne.de/slackware/slackware64-14.1/slackware64/$set/
	wget -nv -r -l1 --no-parent -A tgz http://mirror.netcologne.de/slackware/slackware64-14.1/slackware64/$set/
	wget -O mirror.netcologne.de/slackware/slackware64-14.1/slackware64/$set/tagfile -nv http://mirror.netcologne.de/slackware/slackware64-14.1/slackware64/$set/tagfile
done

mkdir $CHROOT_DIR

# we need tar-1.13 from the tar package for pkginstall to work
tar xf mirror.netcologne.de/slackware/slackware64-14.1/slackware64/a/tar-1.26-x86_64-1.tgz bin/tar-1.13

# we need installpkg from pkgtools
# we have to patch it, so it uses the correct tar and doesn't destroy things
# on the host!
tar xf mirror.netcologne.de/slackware/slackware64-14.1/slackware64/a/pkgtools-14.1-noarch-2.tgz sbin/installpkg
sed -i "s@TAR=.*@TAR=$PWD/bin/tar-1.13@g" sbin/installpkg
sed -i 's@/sbin/ldconfig@/bin/true@g' sbin/installpkg

# install the bare minimum
for package in aaa_base aaa_elflibs aaa_terminfo bash glibc-solibs pkgtools tar coreutils util-linux xz grep sed; do
	package_file=`find mirror.netcologne.de -name "$package*.t[xg]z"`	
	sbin/installpkg --terse --root $CHROOT_DIR $package_file
done

# make the packages accessible in the chrooted environment
cp -a mirror.netcologne.de slackware/

for package in `cat slackware_packages`; do
	package_file=`find mirror.netcologne.de -name "$package*.t[xg]z"`
	chroot $CHROOT_DIR /sbin/installpkg --terse $package_file
done

rm -f sbin/installpkg
rmdir sbin
rm -f bin/tar-1.13
rmdir bin

systemd-nspawn -D $CHROOT_DIR 
chroot $CHROOT_DIR

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/slackware64-base:14.1


