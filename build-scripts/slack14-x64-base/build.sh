#!/bin/sh

# Slackware 14.1 (64-bit)

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

CHROOT_DIR=slack14-x64

rm -rf $CHROOT_DIR

mkdir $CHROOT_DIR

for set in a ap l n; do
	if test ! -d mirror.netcologne.de/slackware/slackware64-14.1/slackware64/$set; then
		mkdir -p mirror.netcologne.de/slackware/slackware64-14.1/slackware64/$set
	fi
done

# fetch minimal set of packages from a mirror
while read set package ext; do
	EXISTS=`find mirror.netcologne.de/slackware/slackware64-14.1/slackware64/$set -type f -name "$package*.$ext" | wc -l`
	if test $EXISTS -eq 0; then
		echo "Fetching $set, $package, $ext.."
		wget -q -r -l1 -np "http://mirror.netcologne.de/slackware/slackware64-14.1/slackware64/$set/" -A "$package-*.$ext"
		if test $? != 0; then
			echo "ERROR: wget failed with $? for ($set, $package, $ext)"
			exit 1
		fi
		EXISTS=`find mirror.netcologne.de/slackware/slackware64-14.1/slackware64/$set -type f -name "$package-*.$ext" | wc -l`
		if test $EXISTS -eq 0; then
			echo "ERROR: no file found for ($set, $package, $ext)"
			exit 1
		fi
	else
		echo "Already cached $set, $package, $ext.."
	fi
done < slackware_packages

# get the package meta tagfiles
for set in a ap l n; do
	if test ! -f $mirror.netcologne.de/slackware/slackware64-14.1/slackware64/$set/tagfile; then
		wget -O mirror.netcologne.de/slackware/slackware64-14.1/slackware64/$set/tagfile -nv http://mirror.netcologne.de/slackware/slackware64-14.1/slackware64/$set/tagfile
	fi
done

# we need tar-1.13 from the tar package for pkginstall to work
tar xf mirror.netcologne.de/slackware/slackware64-14.1/slackware64/a/tar-1.26-x86_64-1.tgz bin/tar-1.13

# we need installpkg from pkgtools
# we have to patch it, so it uses the correct tar and doesn't destroy things
# on the host!
tar xf mirror.netcologne.de/slackware/slackware64-14.1/slackware64/a/pkgtools-14.1-noarch-2.tgz sbin/installpkg
sed -i "s@TAR=.*@TAR=$PWD/bin/tar-1.13@g" sbin/installpkg

# provide basic configuration for ld cache
mkdir $CHROOT_DIR/etc
printf "/lib64\n/usr/lib64\n" > $CHROOT_DIR/etc/ld.so.conf

# install the bare minimum from outside the crhooted environment
for package in aaa_base aaa_elflibs aaa_terminfo bash glibc-solibs pkgtools tar coreutils util-linux xz grep sed; do
	package_file=`find mirror.netcologne.de -name "$package*.t[xg]z"`	
	sbin/installpkg --terse --root $CHROOT_DIR $package_file
done

# make the packages accessible in the chrooted environment
mkdir $CHROOT_DIR/packages
cp -a mirror.netcologne.de $CHROOT_DIR/packages/.

# make sure the crhooted envirnment also has access to the old tar
cp -a bin/tar-1.13 $CHROOT_DIR/usr/bin

# install packages properly inside chrooted environment
for package in `cut -f 2 slackware_packages`; do
	package_file=`find mirror.netcologne.de -name "$package*.t[xg]z"`
	chroot $CHROOT_DIR /sbin/installpkg --terse /packages/$package_file
done

# DNS resolver (copy from the host)
cp /etc/resolv.conf $CHROOT_DIR/etc/

# enable a mirror for slackpkg
sed -i 's@^# http://sunsite.informatik.rwth-aachen.de@http://sunsite.informatik.rwth-aachen.de@g' $CHROOT_DIR/etc/slackpkg/mirrors

# update slackpkg
chroot $CHROOT_DIR slackpkg update
chroot $CHROOT_DIR slackpkg update gpg

# clean up
rm -f sbin/installpkg
rmdir sbin
rm -f bin/tar-1.13
rmdir bin

docker rmi wolframe/slack14-x64-base:latest
docker rmi wolframe/slack14-x64-base:14.1

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/slack14-x64-base:14.1
docker tag wolframe/slack14-x64-base:14.1 wolframe/slack14-x64-base:latest
