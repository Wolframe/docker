#!/bin/sh

docker rmi wolframe/fed20-x64-dev:latest
docker build -t wolframe/fed20-x64-dev .
