import 'package:json_annotation/json_annotation.dart';
import 'package:sofomo_task/structs/owner.dart';
part 'github_pr.g.dart';

@JsonSerializable()
class GitHubPr {
  final String title;
  final Owner user;

  GitHubPr({required this.title, required this.user});

  factory GitHubPr.fromJson(Map<String, dynamic> json) =>
      _$GitHubPrFromJson(json);

  Map<String, dynamic> toJson() => _$GitHubPrToJson(this);
}
