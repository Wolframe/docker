#!/bin/sh

docker rmi wolframe/centos5-x86_64-wolframe-build
docker build -t wolframe/centos5-x86_64-wolframe-build .

