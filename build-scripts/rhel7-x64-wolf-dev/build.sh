#!/bin/sh

docker rmi wolframe/rhel7-x64-wolf-dev
docker build -t wolframe/rhel7-x64-wolf-dev .

