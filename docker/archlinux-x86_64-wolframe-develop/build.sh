#!/bin/sh

docker rmi wolframe/archlinux-x86_64-wolframe-develop
docker build -t wolframe/archlinux-x86_64-wolframe-develop .

