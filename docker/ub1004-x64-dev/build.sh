#!/bin/sh

docker rmi wolframe/ub1004-x64-dev:latest
docker build -t wolframe/ub1004-x64-dev .
