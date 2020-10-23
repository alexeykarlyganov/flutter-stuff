import 'package:auto_update_pubver/auto_update_pubver.dart';
import 'package:test/test.dart';

void main() {
  group('Tests for semantic version', () {
    SemanticVersionApi semanticVersionApi;

    setUp(() {
      semanticVersionApi = SemanticVersionApi(version: '0.0.1+build.12412');
    });

    test('check if version is valid', () {
      expect(semanticVersionApi.majorVersion, '0');
      expect(semanticVersionApi.minorVersion, '0');
      expect(semanticVersionApi.patchVersion, '1');
    });

    test('update major version and check new version', () {
      semanticVersionApi.updateVersion(type: SemanticVersionType.major);

      expect(semanticVersionApi.majorVersion, '1');
      expect(semanticVersionApi.minorVersion, '0');
      expect(semanticVersionApi.patchVersion, '0');
    });

    test('update minor version and check new version', () {
      semanticVersionApi.updateVersion(type: SemanticVersionType.minor);

      expect(semanticVersionApi.majorVersion, '0');
      expect(semanticVersionApi.minorVersion, '1');
      expect(semanticVersionApi.patchVersion, '0');
    });

    test('update patch version and check new version', () {
      semanticVersionApi.updateVersion(type: SemanticVersionType.patch);

      expect(semanticVersionApi.majorVersion, '0');
      expect(semanticVersionApi.minorVersion, '0');
      expect(semanticVersionApi.patchVersion, '2');
    });
  });
}
