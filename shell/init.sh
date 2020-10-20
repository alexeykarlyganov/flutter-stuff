#!/bin/sh

set -e

# useful functions
info() {
	printf -- '\033[1;32m%s \033[0m\n' "$@"
}

prompt() {
	assume='ask'
	printf -- '\033[1;33m%s \033[0m[y/N]: ' "$@"
	if [ "$assume" = 'yes' ]; then
		printf -- '%s\n' 'y'
		return 0
	elif [ "$assume" = 'no' ]; then
		printf -- '%s\n' 'n'
		return 1
	else
		read answer
		case "$answer" in
			[yY]|[yY][eE][sS]) return 0 ;;
			*) return 1 ;;
		esac
	fi
}

info "Installing required dependecies..."

sudo apt install -q zsh git wget curl zip unzip xz-utils openjdk-8-jdk openjdk-8-jre libglu1-mesa

if prompt 'Install packages for fastlane? (optional)'; then

info "Installing optional dependecies..."
sudo apt install -q lib32stdc++6 libstdc++6 locales ruby-full

else

info "Skiping install optional dependecies..."
fi

info "Silence warnings when accepting android licenses..."

mkdir -p ~/.android
touch ~/.android/repositories.cfg

info "Configuring the install Android SDK..."

export ANDROID_SDK_URL="https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip"
export ANDROID_SDK_ROOT="/opt/android-sdk"
sudo mkdir -p "${ANDROID_SDK_ROOT}"

info "Downloading Android SDK..."

export ANDROID_SDK_ARCHIVE="${ANDROID_SDK_ROOT}/archive"
sudo wget "${ANDROID_SDK_URL}" -O "${ANDROID_SDK_ARCHIVE}"
sudo unzip -d "${ANDROID_SDK_ROOT}" "${ANDROID_SDK_ARCHIVE}"

info "Install Android SDK..."

sudo yes | sudo "${ANDROID_SDK_ROOT}/tools/bin/sdkmanager" "tools" "build-tools;29.0.3" "platforms;android-29" "platform-tools" "patcher;v4"

info "Clean..."

sudo rm "${ANDROID_SDK_ARCHIVE}"

info "Installing Android SDK completed!"
info 'Installing Flutter...'

export FLUTTER_DIR="/opt/flutter"
export PATH="$PATH:${FLUTTER_DIR}/bin"
export PATH="${ANDROID_SDK_ROOT}/tools:${PATH}"
export PATH="${ANDROID_SDK_ROOT}/tools/bin:${PATH}"

sudo git clone https://github.com/flutter/flutter.git -b stable --depth 1 ${FLUTTER_DIR}

info "Changing the owner of android-sdk and flutter folders..."

sudo chown -R $(whoami):$(whoami) $FLUTTER_DIR
sudo chown -R $(whoami):$(whoami) $ANDROID_SDK_ROOT

info "Configuring Flutter..."

yes | flutter doctor --android-licenses
flutter config --no-analytics

info 'Flutter and Android SDK succefully installed! Time to create cool things :)'
info 'Do not remember to add exports to your rc file .zshrc, .bashrc and etc'
info '	export FLUTTER_DIR="/opt/flutter"'
info '	export PATH="$PATH:${FLUTTER_DIR}/bin"'
info '	export ANDROID_SDK_ROOT="/opt/android-sdk"'
info '	export PATH="${ANDROID_SDK_ROOT}/tools:${PATH}"'
info '	export PATH="${ANDROID_SDK_ROOT}/tools/bin:${PATH}"'