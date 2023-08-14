import 'package:json_annotation/json_annotation.dart';
import 'package:sofomo_task/structs/owner.dart';
part 'github_repository.g.dart';

@JsonSerializable()
class GitHubRepository {
  final String name;
  final Owner owner;

  GitHubRepository({required this.name, required this.owner});

  factory GitHubRepository.fromJson(Map<String, dynamic> json) =>
      _$GitHubRepositoryFromJson(json);

  Map<String, dynamic> toJson() => _$GitHubRepositoryToJson(this);
}
