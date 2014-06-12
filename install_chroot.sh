#!/bin/sh

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

# Centos 5

CHROOT_DIR=centos5

mkdir $CHROOT_DIR

mkdir -p $CHROOT_DIR/var/lib/rpm

rpm -v --rebuilddb --root=`pwd`/$CHROOT_DIR

wget http://mirror.centos.org/centos/5.10/os/x86_64/CentOS/centos-release-5-10.el5.centos.x86_64.rpm

rpm -v -i --root=`pwd`/$CHROOT_DIR --nodeps centos-release-5-10.el5.centos.x86_64.rpm

rm -f centos-release-5-10.el5.centos.x86_64.rpm

wget http://mirror.centos.org/centos/5.10/os/x86_64/RPM-GPG-KEY-CentOS-5

rpm -v --root=`pwd`/$CHROOT_DIR --import RPM-GPG-KEY-CentOS-5

rm RPM-GPG-KEY-CentOS-5

yum --installroot=`pwd`/$CHROOT_DIR install -y yum
yum --installroot=`pwd`/$CHROOT_DIR install -y coreutils procps net-tools wget

cp /etc/resolv.conf $CHROOT_DIR/etc/

# rebuild the RPM database with the rpm inside the chroot
cd $CHROOT_DIR/var/lib/rpm
mv Packages Packages-ORIG
db_dump Packages-ORIG 
chroot $CHROOT_DIR /bin/rpm -v --rebuilddb

cd /var/lib/rpm
     mv Packages Packages-ORIG
     db_dump-4.6.18 Packages-ORIG | db_load-4.5.20 Packages
    rpm --rebuilddb
    rpm -qa



systemd-nspawn -D $CHROOT_DIR 
chroot $CHROOT_DIR

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/centos-64-base:6.5

# Centos 6 (64-bit)

CHROOT_DIR=centos6-x86_64

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

systemd-nspawn -D $CHROOT_DIR 
chroot $CHROOT_DIR

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/centos6-x86_64-base:6.5
docker tag wolframe/centos6-x86_64-base:6.5 wolframe/centos6-x86_64-base:latest
 
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

# Debian

CHROOT_DIR=debian7-x86_64

mkdir $CHROOT_DIR

debootstrap --verbose --variant=minbase wheezy $CHROOT_DIR http://http.debian.net/debian/

systemd-nspawn -D $CHROOT_DIR 
chroot $CHROOT_DIR

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/debian7-x86_64-base:7.5
docker tag wolframe/debian7-x86_64-base:7.5 wolframe/debian7-x86_64-base:latest

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

# Ubuntu 14.04

CHROOT_DIR=ubuntu1404-x86_64

mkdir $CHROOT_DIR

debootstrap --arch amd64 --verbose --variant=minbase trusty $CHROOT_DIR http://mirror.switch.ch/ftp/mirror/ubuntu/

# needed for package configuration
chroot $CHROOT_DIR apt-get install -y --force-yes apt-utils

# needed for package GPG signature check
chroot $CHROOT_DIR apt-get install -y --force-yes gpgv

systemd-nspawn -D $CHROOT_DIR 
chroot $CHROOT_DIR

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/ubuntu1404-x86_64-base:14.04
docker tag wolframe/ubuntu1404-x86_64-base:14.04 wolframe/ubuntu1404-x86_64-base:latest

# Slackware

CHROOT_DIR=slackware-x86_64

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

cp /etc/resolv.conf $CHROOT_DIR/etc/

rm -f sbin/installpkg
rmdir sbin
rm -f bin/tar-1.13
rmdir bin

systemd-nspawn -D $CHROOT_DIR 
chroot $CHROOT_DIR

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/slackware-x86_64-base:14.1
docker tag wolframe/slackware-x86_64-base:14.1 wolframe/slackware-x86_64-base:latest
