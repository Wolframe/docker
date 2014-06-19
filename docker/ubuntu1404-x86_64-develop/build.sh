#!/bin/sh

docker rmi wolframe/ubuntu1404-x86_64-develop:latest
docker build -t wolframe/ubuntu1404-x86_64-develop .
