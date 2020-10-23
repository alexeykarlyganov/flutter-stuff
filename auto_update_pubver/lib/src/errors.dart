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
