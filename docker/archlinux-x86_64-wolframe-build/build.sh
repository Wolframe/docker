#!/bin/sh

docker rmi wolframe/archlinux-x86_64-wolframe-build
docker build -t wolframe/archlinux-x86_64-wolframe-build .

