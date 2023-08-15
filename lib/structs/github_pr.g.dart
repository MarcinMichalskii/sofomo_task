// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_pr.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GitHubPr _$GitHubPrFromJson(Map<String, dynamic> json) => GitHubPr(
      title: json['title'] as String,
      user: Owner.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GitHubPrToJson(GitHubPr instance) => <String, dynamic>{
      'title': instance.title,
      'user': instance.user,
    };
