import 'package:json_annotation/json_annotation.dart';
import 'package:sofomo_task/structs/owner.dart';
part 'github_repository.g.dart';

@JsonSerializable()
class GitHubRepository {
  final int id;
  final String name;
  final Owner owner;
  @JsonKey(name: 'stargazers_count')
  final int? stargazersCount;
  final int forks;
  @JsonKey(name: 'open_issues')
  final int openIssues;

  GitHubRepository(
      {required this.id,
      required this.name,
      required this.owner,
      required this.forks,
      required this.openIssues,
      required this.stargazersCount});

  factory GitHubRepository.fromJson(Map<String, dynamic> json) =>
      _$GitHubRepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$GitHubRepositoryToJson(this);
}
