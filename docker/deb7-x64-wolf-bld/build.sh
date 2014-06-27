#!/bin/sh

docker rmi wolframe/deb7-x64-wolf-bld
docker build -t wolframe/deb7-x64-wolf-bld .

