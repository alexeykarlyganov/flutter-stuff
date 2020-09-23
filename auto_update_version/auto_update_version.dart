import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:yaml/yaml.dart';

import './src/semantic_version_api.dart';

void main(List<String> args) {
  String pubspecPath = args[0];

  Stream<List<int>> stream = File(pubspecPath).openRead();
  StringBuffer buffer = StringBuffer();

  SemanticVersionApi sva;

  stream.transform(utf8.decoder).listen(
        (String data) => buffer.write(data),
        onDone: () {
          YamlMap doc = loadYaml(buffer.toString());

          try {
            sva = SemanticVersionApi(version: doc['version']);

            sva.updateMinorVersion();

            String updatedYaml = buffer.toString().replaceFirst(
                  RegExp(
                      r'version:\s+\d+\.{1}\d+\.{1}\d+[+-]{1}[0-9A-Za-z-\.]+'),
                  'version: $sva',
                );
            buffer.clear();
            buffer.write(updatedYaml);
            File(pubspecPath).writeAsStringSync(buffer.toString());
          } on InvalidVersionFormatException catch (err) {
            print(err.toString());
          }
        },
        onError: (err) => print(err),
        cancelOnError: true,
      );
}
