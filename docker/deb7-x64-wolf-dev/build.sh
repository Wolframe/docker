#!/bin/sh

docker rmi wolframe/deb7-x64-wolf-dev:latest
docker build -t wolframe/deb7-x64-wolf-dev .
