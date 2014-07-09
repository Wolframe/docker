#!/bin/sh

docker rmi wolframe/fed20-x64-wolf-dev
docker build -t wolframe/fed20-x64-wolf-dev .

