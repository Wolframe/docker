#!/bin/sh

docker rmi wolframe/ub1404-x64-dev:latest
docker build -t wolframe/ub1404-x64-dev .
