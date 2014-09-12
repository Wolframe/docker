#!/bin/sh

docker rmi wolframe/rhel6-x64-dev:latest
docker build -t wolframe/rhel6-x64-dev .
