#!/bin/sh

# ArchLinux

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:${PATH}

CHROOT_DIR=archlinux-x86_64

rm -rf $CHROOT_DIR

mkdir $CHROOT_DIR

pacstrap -c -d $CHROOT_DIR filesystem grep findutils coreutils glibc bash pacman procps-ng

sed -i 's/^SigLevel.*/SigLevel = Never/g' $CHROOT_DIR/etc/pacman.conf

docker rmi wolframe/archlinux-x86_64-base:latest
docker rmi wolframe/archlinux-x86_64-base:201406

tar --numeric-owner -C $CHROOT_DIR -cf - . | docker import - wolframe/archlinux-x86_64-base:201406
docker tag wolframe/archlinux-x86_64-base:201406 wolframe/archlinux-x86_64-base:latest
