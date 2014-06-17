#!/bin/sh

docker rmi wolframe/centos6-x86_64-wolframe-develop
docker build -t wolframe/centos6-x86_64-wolframe-develop .

