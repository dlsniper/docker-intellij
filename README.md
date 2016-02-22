# Docker image for IntelliJ IDEA Community, Go and Go plugin

[![Circle CI](https://circleci.com/gh/dlsniper/docker-intellij.svg?style=svg)](https://circleci.com/gh/dlsniper/docker-intellij)

The image contains the following software:

- [IntelliJ IDEA Community 15.0.2](https://www.jetbrains.com/idea/)
- [Go 1.5.2](https://golang.org/)
- [Go plugin (nightly, 0.10.749)](https://plugins.jetbrains.com/plugin/5047)
- [.ignore plugin (release, 1.2)](https://plugins.jetbrains.com/plugin/7495)
- [Markdown plugin (release, 8.0.0.20151106)](https://plugins.jetbrains.com/plugin/5970)

## Running

By running the following command you'll be able to start the container

```bash
docker run -tdi \
           -e DISPLAY=${DISPLAY} \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v ${HOME}/.IdeaIC15_docker:/home/developer/.IdeaIC15 \
           -v ${GOPATH}:/home/developer/go \
           dlsniper/docker-intellij
```

The command will do the following:

- save the IDE preferences into `<your-HOME-dir>/.IdeaIC15_docker`
- mounts the GOPATH from your computer to the one in the container. This
assumes you have a single directory. If you have multiple directories in your
GOPATH, then see below how you can customize this to run correctly.

## Customizing the container

You can replace the `${GOPATH}` environment variable to a hardcoded path that
you have in your directory.

You can also choose to save the preferences in another directory.

For an example script to launch this, see below:

```bash
#!/usr/bin/env bash

GOPATH=/path/to/your/GOPATH
PREF_DIR=${HOME}/.IdeaIC15_docker

docker run -tdi \
           -e DISPLAY=${DISPLAY} \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           -v ${PREF_DIR}:/home/developer/.IdeaIC15 \
           -v ${GOPATH}:/home/developer/go \
           dlsniper/docker-intellij
```

## Updating the container

To update the container, simply run:

```shell
docker pull dlsniper/docker-intellij
```

Each of the plugins can be updated individually at any time, and other plugins
can be installed as well.

However, to update IntelliJ IDEA itself, the docker image will need to be
updated.

## License

The MIT License (MIT)

Copyright (c) 2015 Florin Patan

If you want to read the full license text, please see the [LICENSE](LICENSE) file
in this directory.

IntelliJ IDEA and all the other plugins are or may be trademarks of their
respective owners / creators. Please read the individual licenses for them.
