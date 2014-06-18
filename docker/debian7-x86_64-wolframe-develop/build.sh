#!/bin/sh

docker rmi wolframe/debian7-x86_64-wolframe-develop:latest
docker build -t wolframe/debian7-x86_64-wolframe-develop .
