import 'package:http/http.dart' as http;

import '../models/github_issue_model.dart';

class GitHubIssueAPI {
  final String project;
  final String owner;

  static String githubUrl = 'https://api.github.com';

  String _url;

  GitHubIssueAPI({this.project, this.owner}) {
    _url = '$githubUrl/repos/$owner/$project/issues';
  }

  /// Creating an issue
  Future<void> createIssue({
    String title,
    String body,
    int milestone,
    List<String> labels,
    List<String> assignees,
  }) async {
    var model = GithubIssueModel(title: title, body: body);

    var response = await http.post(
      _url,
      headers: model.headers,
      body: model.request_body(),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('Issue succesfully created.');
    }
  }

  String get url => _url;
}
