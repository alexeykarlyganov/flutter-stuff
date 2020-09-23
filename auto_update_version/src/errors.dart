class InvalidVersionFormatException implements Exception {
  String _message;

  InvalidVersionFormatException(
      [String message =
          'Invalid version format!\nValid format: x.y.z[-+][0-9a-z.-]. Example: 1.2.4+build.2.b8f12d7']) {
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}

class InvalidArgumentsException implements Exception {
  String _message;

  InvalidVersionFormatException(
      [String message = 'Invalid arguments! Argmunts must be more than 2!\n'
          'Example of command: dart auto_update_version.dart <path to pubspec.yaml> <type>\n'
          'Type value can be major, minor or patch.']) {
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
