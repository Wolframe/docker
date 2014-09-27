#!/bin/sh

docker rmi wolframe/arch-686-dev:latest
docker build -t wolframe/arch-686-dev .
