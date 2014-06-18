#!/bin/sh

docker rmi wolframe/debian7-x86_64-wolframe-build
docker build -t wolframe/debian7-x86_64-wolframe-build .

