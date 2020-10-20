import 'package:http/http.dart' as http;

import '../models/github_issue_model.dart';

class GitHubIssueAPI {
  final String project;
  final String owner;
  final String token;

  static const String BASE_URL = 'https://api.github.com';

  String _url;

  GitHubIssueAPI({
    this.project,
    this.owner,
    this.token,
  }) {
    _url = '$BASE_URL/repos/$owner/$project/issues';
  }

  Future<void> createIssue({
    String title,
    String body,
    int milestone,
    List<String> labels,
    List<String> assignees,
  }) async {
    var model = GithubIssueModel(
      title: title,
      body: body,
      milestone: milestone,
    );

    print(model.request_body());

    var response = await http.post(
      _url,
      headers: headers,
      body: model.request_body(),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      print('Issue succesfully created.');
    }
  }

  Map<String, String> get headers => <String, String>{
        'Accept': ' application/vnd.github.v3+json',
        'Authorization': 'token $token',
      };
}
