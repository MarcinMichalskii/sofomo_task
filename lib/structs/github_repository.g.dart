// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubRepository _$GitHubRepositoryFromJson(Map<String, dynamic> json) =>
    GitHubRepository(
      id: json['id'] as int,
      name: json['name'] as String,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      forks: json['forks'] as int,
      openIssues: json['open_issues'] as int,
      stargazersCount: json['stargazers_count'] as int?,
    );

Map<String, dynamic> _$GitHubRepositoryToJson(GitHubRepository instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'owner': instance.owner,
      'stargazers_count': instance.stargazersCount,
      'forks': instance.forks,
      'open_issues': instance.openIssues,
    };
