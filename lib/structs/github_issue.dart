import 'package:json_annotation/json_annotation.dart';
import 'package:sofomo_task/structs/owner.dart';
part 'github_issue.g.dart';

@JsonSerializable()
class GitHubIssue {
  final String title;
  final Owner user;

  GitHubIssue({required this.title, required this.user});

  factory GitHubIssue.fromJson(Map<String, dynamic> json) =>
      _$GitHubIssueFromJson(json);

  Map<String, dynamic> toJson() => _$GitHubIssueToJson(this);
}
