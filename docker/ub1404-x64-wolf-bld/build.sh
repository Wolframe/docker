#!/bin/sh

docker rmi wolframe/ub1404-x64-wolf-bld
docker build -t wolframe/ub1404-x64-wolf-bld .

