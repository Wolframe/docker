#!/bin/sh

docker rmi wolframe/centos6-x86_64-develop:latest
docker build -t wolframe/centos6-x86_64-develop .
