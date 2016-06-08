#!/usr/bin/env bash

docker run -tdi \
           -e DISPLAY=${DISPLAY} \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v ${GOPATH}:/home/developer/go \
           -v ${HOME}/.IdeaIC2016.1_docker:/home/developer/.IdeaIC2016.1 \
           dlsniper/docker-intellij
