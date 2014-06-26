#!/bin/sh

docker rmi wolframe/arch-x64-dev:latest
docker build -t wolframe/arch-x64-dev .
