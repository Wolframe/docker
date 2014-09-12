#!/bin/sh

docker rmi wolframe/arch-x64-wolf-bld
docker build -t wolframe/arch-x64-wolf-bld .

