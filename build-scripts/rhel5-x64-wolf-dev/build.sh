#!/bin/sh

docker rmi wolframe/rhel5-x64-wolf-dev
docker build -t wolframe/rhel5-x64-wolf-dev .

