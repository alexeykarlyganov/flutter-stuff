A library for Dart developers.

Created from templates made available by Stagehand under a BSD-style
[license](https://github.com/dart-lang/stagehand/blob/master/LICENSE).

## Usage

A simple usage example:

```dart
import 'dart:io';

import 'package:yaml/yaml.dart';

import 'src/semantic_version_api.dart';
import 'src/errors.dart';

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

```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: http://example.com/issues/replaceme
