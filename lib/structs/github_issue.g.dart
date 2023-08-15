// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubIssue _$GitHubIssueFromJson(Map<String, dynamic> json) => GitHubIssue(
      title: json['title'] as String,
      user: Owner.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GitHubIssueToJson(GitHubIssue instance) =>
    <String, dynamic>{
      'title': instance.title,
      'user': instance.user,
    };
