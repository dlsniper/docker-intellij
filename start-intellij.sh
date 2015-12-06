#!/usr/bin/env bash

docker run -tdi \
           -e DISPLAY=${DISPLAY} \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v ${GOPATH}:/home/developer/go \
           -v ${HOME}/.IdeaIC15_docker:/home/developer/.IdeaIC15 \
           dlsniper/docker-intellij
