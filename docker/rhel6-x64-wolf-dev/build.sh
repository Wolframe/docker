#!/bin/sh

docker rmi wolframe/rhel6-x64-wolf-dev
docker build -t wolframe/rhel6-x64-wolf-dev .

