import 'errors.dart';

enum SemanticVersionType { major, minor, patch }

/// A class that present the semantic versioning API (x.y.z)
class SemanticVersionApi {
  String _majorVersion;
  String _minorVersion;
  String _patchVersion;

  String _buildVersion;

  static String versionPattern =
      r'(\d+)\.{1}(\d+)\.{1}(\d+)([+-]{1}[0-9A-Za-z-\.]+)';

  final String version;

  SemanticVersionApi({this.version}) {
    RegExp re = RegExp(versionPattern, caseSensitive: false);
    if (!re.hasMatch(version)) {
      throw InvalidVersionFormatException();
    }
    Iterable<RegExpMatch> matches = re.allMatches(version);

    _majorVersion = matches.first.group(1);
    _minorVersion = matches.first.group(2);
    _patchVersion = matches.first.group(3);
    _buildVersion = matches.first.group(4);
  }

  void _updateBuildVersion() {
    String version = "$majorVersion.$minorVersion.$patchVersion";
    String hash = version.hashCode.toString();

    _buildVersion = "build.$hash";
  }

  void updateVersion({SemanticVersionType type}) {
    switch (type) {
      case SemanticVersionType.major:
        _patchVersion = _minorVersion = '0';
        _majorVersion = (int.parse(_majorVersion) + 1).toString();
        _updateBuildVersion();
        break;
      case SemanticVersionType.minor:
        _patchVersion = '0';
        _minorVersion = (int.parse(_minorVersion) + 1).toString();
        _updateBuildVersion();
        break;
      case SemanticVersionType.patch:
        _patchVersion = (int.parse(_patchVersion) + 1).toString();
        _updateBuildVersion();
        break;
      default:
        print('Unknown type of semantic version.'
            'Available types: major, minor, patch.');
        break;
    }
  }

  static SemanticVersionType whatType(String type) {
    // FIXME: change this? maybe...
    switch (type) {
      case 'major':
        return SemanticVersionType.major;
      case 'minor':
        return SemanticVersionType.minor;
      case 'patch':
        return SemanticVersionType.patch;
      default:
        return null;
    }
  }

  String get majorVersion => _majorVersion;
  String get minorVersion => _minorVersion;
  String get patchVersion => _patchVersion;

  String get buildVersion => _buildVersion;

  @override
  String toString() {
    return '$majorVersion.$minorVersion.$patchVersion+$buildVersion';
  }
}
