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

/// A class that presen the semantic versioning API (x.y.z)
class SemanticVersionApi {
  String _majorVersion;
  String _minorVersion;
  String _patchVersion;

  String _buildVersion = null;

  static RegExp versionPattern = RegExp(
    r'^(\d+)\.{1}(\d+)\.{1}(\d+)([+-]{1}[0-9A-Za-z-\.]+)$',
    caseSensitive: false,
  );

  final String version;

  SemanticVersionApi({this.version}) {
    if (!versionPattern.hasMatch(version)) {
      throw InvalidVersionFormatException();
    }
    Iterable<RegExpMatch> matches = versionPattern.allMatches(version);

    _majorVersion = matches.first.group(1);
    _minorVersion = matches.first.group(2);
    _patchVersion = matches.first.group(3);
    _buildVersion = matches.first.group(4);
  }

  // ignore: todo
  // TODO: Implement a method for update and reset build version
  void updateBuildVersion() {}
  void resetBuildVersion() {}

  void updateMajorVersion() {
    _patchVersion = _minorVersion = '0';
    // resetBuildVersion();
    int newVersion = int.parse(_majorVersion);
    _majorVersion = (++newVersion).toString();
  }

  void updateMinorVersion() {
    _patchVersion = '0';
    // resetBuildVersion();
    int newVersion = int.parse(_minorVersion);
    _minorVersion = (++newVersion).toString();
  }

  void updatePatchVersion() {
    // resetBuildVersion();
    int newVersion = int.parse(_patchVersion);
    _patchVersion = (++newVersion).toString();
  }

  String get majorVersion => _majorVersion;
  String get minorVersion => _minorVersion;
  String get patchVersion => _patchVersion;

  String get buildVersion => _buildVersion;

  @override
  String toString() {
    return '$majorVersion.$minorVersion.$patchVersion$buildVersion';
  }
}
