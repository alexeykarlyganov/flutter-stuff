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
    this.body = '',
    this.milestone,
    this.labels = const [],
    this.assignees = const [],
  }) : assert(title != null);

  String request_body() {
    Map<String, dynamic> parameters = {};

    parameters['body'] = body.isEmpty ? '' : body;
    parameters['milestone'] ??= milestone;
    parameters['labels'] = labels.isEmpty ? [] : labels;
    parameters['assignees'] = assignees.isEmpty ? [] : assignees;

    return jsonEncode(<String, dynamic>{'title': title, ...parameters});
  }
}
