#!/bin/sh

docker rmi wolframe/centos5-x86_64-develop:latest
docker build -t wolframe/centos5-x86_64-develop .
