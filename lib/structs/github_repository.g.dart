// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubRepository _$GitHubRepositoryFromJson(Map<String, dynamic> json) =>
    GitHubRepository(
      name: json['name'] as String,
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GitHubRepositoryToJson(GitHubRepository instance) =>
    <String, dynamic>{
      'name': instance.name,
      'owner': instance.owner,
    };
