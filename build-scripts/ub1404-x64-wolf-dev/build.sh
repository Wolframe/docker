#!/bin/sh

docker rmi wolframe/ub1404-x64-wolf-dev:latest
docker build -t wolframe/ub1404-x64-wolf-dev .
