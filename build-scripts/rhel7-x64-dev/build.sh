#!/bin/sh

docker rmi wolframe/rhel7-x64-dev:latest
docker build -t wolframe/rhel7-x64-dev .
