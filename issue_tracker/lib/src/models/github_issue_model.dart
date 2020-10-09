import 'dart:convert';

import 'package:meta/meta.dart';

class GithubIssueModel {
  final String title;
  final String body;
  final int milestone;
  final List<String> labels;
  final List<String> assignees;

  GithubIssueModel({
    @required this.title,
    this.body,
    this.milestone,
    this.labels,
    this.assignees,
  }) : assert(title != null);

  String request_body() {
    Map<String, dynamic> parameters = {};

    parameters['body'] = body.isEmpty ? '' : body;
    parameters['milestone'] ??= milestone;

    return jsonEncode(<String, dynamic>{'title': title, ...parameters});
  }

  Map<String, String> get headers =>
      <String, String>{'Accept': ' application/vnd.github.v3+json'};
}
