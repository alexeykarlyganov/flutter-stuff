FROM elementary/docker:stable

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt update -qq
RUN apt full-upgrade -yqq
RUN apt install -yqq --no-install-recommends \
    # for flutter and android sdk
    build-essential \
    xz-utils \
    openjdk-8-jdk \
    openjdk-8-jre \
    # for fastlane
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
    unzip 

RUN apt autoclean -yq
RUN apt autoremove -yqq

# Silence warnings when accepting android licenses.
RUN mkdir -p ~/.android
RUN touch ~/.android/repositories.cfg

# Install the Android SDK Dependency.
ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ENV ANDROID_SDK_ROOT="/opt/android-sdk"
RUN mkdir -p "${ANDROID_SDK_ROOT}"

# Download SDK.
ENV ANDROID_SDK_ARCHIVE="${ANDROID_SDK_ROOT}/archive"
RUN wget "${ANDROID_SDK_URL}" -O "${ANDROID_SDK_ARCHIVE}" --quiet
RUN unzip -q -d "${ANDROID_SDK_ROOT}" "${ANDROID_SDK_ARCHIVE}"

# Suppressing output of sdkmanager to keep log size down
RUN yes | "${ANDROID_SDK_ROOT}/tools/bin/sdkmanager"    "tools" \
                                                        "build-tools;30.0.1" \
                                                        "platforms;android-30" \ 
                                                        "platform-tools" > /dev/null
RUN rm "${ANDROID_SDK_ARCHIVE}"
ENV PATH="${ANDROID_SDK_ROOT}/tools:${PATH}"
ENV PATH="${ANDROID_SDK_ROOT}/tools/bin:${PATH}"

# Set locale to en_US
RUN locale-gen en_US "en_US.UTF-8" && dpkg-reconfigure locales
ENV LANG en_US.UTF-8

# Install bundler and fastlane
RUN gem install bundler --quiet
RUN gem install fastlane -Nq

# Install Flutter
ENV FLUTTER_DIR="/opt/flutter"
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 ${FLUTTER_DIR}
ENV PATH "$PATH:${FLUTTER_DIR}/bin"

RUN yes | flutter doctor --android-licenses > /dev/null
RUN flutter config --no-analytics

# Check versions of dependecies
RUN flutter doctor -v
RUN java -version
RUN ruby --version
