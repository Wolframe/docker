#!/bin/sh

docker rmi wolframe/rhel5-x64-dev:latest
docker build -t wolframe/rhel5-x64-dev .
