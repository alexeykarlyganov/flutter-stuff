import 'package:issue_tracker/issue_tracker.dart';

Future<void> main(List<String> args) async {
  var github = GitHubIssueAPI(
    owner: 'alexeykarlyganov',
    project: 'flutter-stuff',
    token: String.fromEnvironment('GITHUB_TOKEN'),
  );

  await github.createIssue(
    title: 'Test issue',
    body: 'Empty description',
  );
}
