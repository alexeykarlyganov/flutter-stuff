import 'dart:io';

import 'package:yaml/yaml.dart';

import 'package:auto_update_pubver/auto_update_pubver.dart';

void main(List<String> args) async {
  if (args.length < 2) return;

  String pubspecPath = args[0];
  if (!File(pubspecPath).existsSync()) return;

  SemanticVersionType type = SemanticVersionApi.whatType(args[1]);

  if (type == null) return;

  String pubspecStr = await File(pubspecPath).readAsString();
  YamlMap doc = loadYaml(pubspecStr);

  try {
    SemanticVersionApi sva = SemanticVersionApi(version: doc['version']);
    sva.updateVersion(type: type);

    pubspecStr = pubspecStr.replaceFirst(
      RegExp('version: ${SemanticVersionApi.versionPattern}'),
      'version: $sva',
    );

    await File(pubspecPath).writeAsString(pubspecStr);
  } on InvalidVersionFormatException catch (err) {
    print(err.toString());
  }
}
