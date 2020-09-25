# flutter-stuff

This repository contains some stuff for Flutter development.

## Auto Update Pubspec Version

Auto update pubspec version using dart

```console
    dart auto_update_version.dart <path to pubspec.yaml> <major|minor|patch>
```

## Docker

.docker folder contains a Dockerfile for Flutter CI/CD and .dockerignore file

### Linux
```console
    sudo docker build -t myimage:core -f .docker/Dockerfile --target core \
        --build-arg ANDROID_BUILD_TOOLS_VERSION=30.0.1 \
        --build-arg ANDROID_PLATFORM_VERSION=30 .
```

## Shell script setup

Works only on Ubuntu/Elementary

```console
    ./shell/init.sh
```

> Note: Do not remember to add execute permission to script