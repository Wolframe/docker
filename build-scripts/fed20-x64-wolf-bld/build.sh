#!/bin/sh

docker rmi wolframe/fed20-x64-wolf-bld
docker build -t wolframe/fed20-x64-wolf-bld .

