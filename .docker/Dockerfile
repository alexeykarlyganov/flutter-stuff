FROM ubuntu:20.04

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update -q && apt-get install -yqq --no-install-recommends \
    # for flutter and android sdk
    xz-utils \
    openjdk-8-jdk \
    openjdk-8-jre \
    # for fastlane
    build-essential \
    lib32stdc++6 \
    libstdc++6 \
    locales \
    ruby-full \
    # for flutter test
    libglu1-mesa \
    lcov \
    # common stuff
    git \
    curl \
    wget \
    zip \
    unzip \
    # Clean up
    && apt autoremove -yq \
    && rm -rf /var/lib/apt/lists/*

# Silence warnings when accepting android licenses
RUN mkdir -p ~/.android && touch ~/.android/repositories.cfg 

# Install the Android SDK Dependency.
ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ENV ANDROID_SDK_ROOT="/opt/android-sdk"
ENV ANDROID_SDK_ARCHIVE="${ANDROID_SDK_ROOT}/archive" 

# Download SDK.
RUN mkdir -p "${ANDROID_SDK_ROOT}" && \
    wget "${ANDROID_SDK_URL}" -O "${ANDROID_SDK_ARCHIVE}" --quiet && \
    unzip -q -d "${ANDROID_SDK_ROOT}" "${ANDROID_SDK_ARCHIVE}"

# Suppressing output of sdkmanager to keep log size down
RUN yes | "${ANDROID_SDK_ROOT}/tools/bin/sdkmanager" "tools" \
                                                     "build-tools;30.0.1" \
                                                     "platforms;android-30" \ 
                                                     "platform-tools" 1> /dev/null
RUN rm "${ANDROID_SDK_ARCHIVE}"
ENV PATH="${ANDROID_SDK_ROOT}/tools:${PATH}"
ENV PATH="${ANDROID_SDK_ROOT}/tools/bin:${PATH}"

# Set locale to en_US
RUN locale-gen en_US "en_US.UTF-8" && dpkg-reconfigure locales
ENV LANG en_US.UTF-8

# Install bundler and fastlane
RUN gem install bundler -q && \
    gem install fastlane -Nq

# Install Flutter
ENV FLUTTER_DIR="/opt/flutter"
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 ${FLUTTER_DIR}
ENV PATH="$PATH:${FLUTTER_DIR}/bin"

# Setup user & group
RUN groupadd --gid 6969 xyzgroup && \
    useradd --uid 1337 --gid 6969 --shell /bin/bash --create-home appuser

# Change owner of flutter and android-sdk folder
RUN chown -R appuser:xyzgroup ${FLUTTER_DIR} && \
    chown -R appuser:xyzgroup ${ANDROID_SDK_ROOT}

# Change user
USER appuser

# Configure Flutter
RUN yes | flutter doctor --android-licenses 1> /dev/null
RUN flutter config --no-analytics && \
    flutter doctor -v

# Setup git
RUN git config --global user.email "email@example.com" && \
    git config --global user.name "Your Name"
