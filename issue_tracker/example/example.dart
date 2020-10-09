import 'package:issue_tracker/issue_tracker.dart';
import 'package:issue_tracker/src/api/github.dart';

Future<void> main(List<String> args) async {
  var github = GitHubIssueAPI(
    owner: 'alexeykarlyganov',
    project: 'flutter-stuff',
  );

  await github.createIssue(title: 'Test issue', body: 'Empty description');
}
