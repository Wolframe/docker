#!/bin/sh

docker rmi wolframe/rhel5-x64-wolf-bld
docker build -t wolframe/rhel5-x64-wolf-bld .

