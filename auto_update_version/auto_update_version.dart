import 'dart:io';

import 'package:yaml/yaml.dart';

import 'src/semantic_version_api.dart';
import 'src/errors.dart';

void main(List<String> args) async {
  if (args.length < 2) throw InvalidArgumentsException();

  String pubspecPath = args[0];
  File pubspecFile = File(pubspecPath);
  if (!pubspecFile.existsSync()) throw InvalidArgumentsException();

  SemanticVersionType type = SemanticVersionApi.whatType(args[1]);

  if (type == null) throw InvalidArgumentsException();

  String pubspecStr = await pubspecFile.readAsString();
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
