# flutter-stuff

This repository contains some stuff for Flutter development.

## Auto Update Pubspec Version

Auto update pubspec version using dart

```
dart auto_update_version.dart <path to pubspec.yaml> <major|minor|patch>
```

## Docker


![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/alexeykarlyganov/flutter-sdk/latest)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/alexeykarlyganov/flutter-sdk/latest)

.docker folder contains a Dockerfile for Flutter CI/CD and .dockerignore file

### Linux
```
sudo DOCKER_BUILDKIT=1 docker build . -t flutter-sdk:latest -f .docker/Dockerfile --compress --target core \
    --build-arg ANDROID_BUILD_TOOLS_VERSION=30.0.1 \
    --build-arg ANDROID_PLATFORM_VERSION=30
```

## Shell script setup

Works only on Ubuntu

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/alexeykarlyganov/flutter-stuff/master/shell/init.sh)"
```
