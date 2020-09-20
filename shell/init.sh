#!/bin/sh

echo "Installing required dependecies..."

sudo apt install -q git wget curl zip unzip xz-utils openjdk-8-jdk openjdk-8-jre libglu1-mesa

read -p "Install optional dependecies ? (for fastlane) (Y/n) " choice

if [ $choice = "Y" ]; then

echo "Installing optional dependecies..."

sudo apt install -q lib32stdc++6 libstdc++6 locales ruby-full

else

echo "Skiping install optional dependecies..."

fi

echo "Silence warnings when accepting android licenses"

mkdir -p ~/.android
touch ~/.android/repositories.cfg

echo "Configuring the install Android SDK..."

export ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
export ANDROID_SDK_ROOT="/opt/android-sdk"
sudo mkdir -p "${ANDROID_SDK_ROOT}"

echo "Downloading Android SDK..."

export ANDROID_SDK_ARCHIVE="${ANDROID_SDK_ROOT}/archive"
sudo wget "${ANDROID_SDK_URL}" -O "${ANDROID_SDK_ARCHIVE}"
sudo unzip -d "${ANDROID_SDK_ROOT}" "${ANDROID_SDK_ARCHIVE}"

echo "Install Android SDK..."

sudo yes | sudo "${ANDROID_SDK_ROOT}/tools/bin/sdkmanager" "tools" "build-tools;30.0.1" "platforms;android-30" "platform-tools" 2> /dev/null

echo "Clean..."

sudo rm "${ANDROID_SDK_ARCHIVE}"

echo "Almost finished..."

export PATH="${ANDROID_SDK_ROOT}/tools:${PATH}"
export PATH="${ANDROID_SDK_ROOT}/tools/bin:${PATH}"

echo "Installing Android SDK completed. \nInstalling Flutter..."

export FLUTTER_DIR="/opt/flutter"
sudo git clone https://github.com/flutter/flutter.git -b stable --depth 1 ${FLUTTER_DIR}
export PATH="$PATH:${FLUTTER_DIR}/bin"

echo "Changing the owner of android-sdk and flutter folders..."

sudo chown -R $(whoami):$(whoami) $FLUTTER_DIR
sudo chown -R $(whoami):$(whoami) $ANDROID_SDK_ROOT

echo "Configuring Flutter..."

yes | flutter doctor --android-licenses
flutter config --no-analytics

echo "Do not remember to add this exports to your .bashrc or .zshrc:"
echo "      export FLUTTER_DIR=\"/opt/flutter\""
echo "      export ANDROID_SDK_ROOT=\"/opt/android-sdk\""
echo "And then write in the console: source ~/.bashrc or ~/.zshrc"

echo "Installing Flutter completed! :)\n"