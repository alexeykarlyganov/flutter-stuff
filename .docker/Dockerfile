# ============================================= ANDROID CONTAINER =============================================
FROM openjdk:8-slim as android

RUN apt-get update -q && apt-get install -yqq --no-install-recommends wget unzip

# Configure the install Android SDK
ENV ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
ENV ANDROID_SDK_ROOT="/opt/android-sdk"
ENV ANDROID_SDK_ARCHIVE="${ANDROID_SDK_ROOT}/archive"

ARG ANDROID_BUILD_TOOLS_VERSION="29.0.3"
ARG ANDROID_PLATFORM_VERSION="29"

# Download and install SDK
RUN mkdir -p "${ANDROID_SDK_ROOT}" && \
    wget "${ANDROID_SDK_URL}" -O "${ANDROID_SDK_ARCHIVE}" --quiet && \
    unzip -q -d "${ANDROID_SDK_ROOT}" "${ANDROID_SDK_ARCHIVE}" && \
    yes | "${ANDROID_SDK_ROOT}/tools/bin/sdkmanager" "tools" \
                                                     "patcher;v4" \
                                                     "platform-tools" \
                                                     "build-tools;${ANDROID_BUILD_TOOLS_VERSION}" \
                                                     "platforms;android-${ANDROID_PLATFORM_VERSION}" 1> /dev/null
RUN rm "${ANDROID_SDK_ARCHIVE}"

# ============================================= FLUTTER CONTAINER =============================================
FROM openjdk:8-slim as flutter

RUN apt-get update -q && apt-get install -yqq --no-install-recommends git

# Install Flutter
ENV FLUTTER_DIR="/opt/flutter"
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 ${FLUTTER_DIR}
ENV PATH="$PATH:${FLUTTER_DIR}/bin"

# ============================================= CORE CONTAINER =============================================
FROM openjdk:8-slim as core

ENV DEBIAN_FRONTEND="noninteractive"
ENV ANDROID_SDK_ROOT="/opt/android-sdk"
ENV FLUTTER_DIR="/opt/flutter"

COPY --from=android /opt/android-sdk ${ANDROID_SDK_ROOT}
COPY --from=flutter /opt/flutter ${FLUTTER_DIR}

ENV PATH="$PATH:${FLUTTER_DIR}/bin"

RUN apt-get update -q && apt-get install -yq --no-install-recommends xz-utils unzip curl zip git && \
    apt-get autoremove -yq && \
    rm -rf /var/lib/apt/lists/*

# Setup user & group
RUN groupadd --gid 6969 xyzgroup && \
    useradd --uid 1337 --gid 6969 --shell /bin/bash --create-home appuser && \
# Change owner of flutter and android-sdk folder
    chown -R appuser:xyzgroup ${FLUTTER_DIR} && \
    chown -R appuser:xyzgroup ${ANDROID_SDK_ROOT}

# Change user
USER appuser

# Configure Flutter
RUN flutter config --no-analytics && \
    yes | flutter doctor --android-licenses 1> /dev/null

# Setup git
RUN git config --global user.email "email@example.com" && \
    git config --global user.name "Your Name"

RUN flutter doctor -v

# TODO: implement fastlane container
# ============================================= FASTLANE CONTAINER =============================================
# FROM openjdk:8-slim as fastlane

# ENV DEBIAN_FRONTEND="noninteractive"

# RUN apt-get update -q && apt-get install -yqq --no-install-recommends \
#     ruby-full \
#     build-essential \
#     libstdc++6 \
#     lib32stdc++6 && \
#     apt-get autoremove -yq && \
#     rm -rf /var/lib/apt/lists/*

# ENV LANG="en_US.UTF-8"

# RUN gem install bundler -q && \
#     gem install fastlane -Nq

# ENV ANDROID_SDK_ROOT="/opt/android-sdk"
# COPY --from=android /opt/android-sdk ${ANDROID_SDK_ROOT}

# # Setup user & group
# RUN groupadd --gid 6969 xyzgroup && \
#     useradd --uid 1337 --gid 6969 --shell /bin/bash --create-home appuser && \
# # Change owner of flutter and android-sdk folder
#     chown -R appuser:xyzgroup ${FLUTTER_DIR} && \
#     chown -R appuser:xyzgroup ${ANDROID_SDK_ROOT}

# # Change user
# USER appuser

# # Configure Flutter
# RUN yes | flutter doctor --android-licenses 1> /dev/null
# RUN flutter config --no-analytics && \
#     flutter doctor -v

# # Setup git
# RUN git config --global user.email "email@example.com" && \
#     git config --global user.name "Your Name"
