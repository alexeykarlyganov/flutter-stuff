#!/usr/bin/zsh

info() {
	printf -- '\033[1;32m%s \033[0m\n' "$@"
}

warn() {
	printf -- '\033[1;33m%s \033[0m\n' "$@"
}

error() {
	printf -- '\033[1;31m%s \033[0m\n' "$@"
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
