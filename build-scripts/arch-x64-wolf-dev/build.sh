#!/bin/sh

docker rmi wolframe/arch-x64-wolf-dev
docker build -t wolframe/arch-x64-wolf-dev .

