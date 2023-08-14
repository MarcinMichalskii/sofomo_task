import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofomo_task/api_parser.dart';
import 'package:sofomo_task/api_state.dart';
import 'package:sofomo_task/structs/github_repository.dart';

const String _githubApiUrl = 'https://api.github.com/users/';

final dioProvider = Provider<Dio>((_) => Dio());

final repositoriesProvider = StateNotifierProvider<RepositoriesNotifier,
    APIResponseState<List<GitHubRepository>>>(
  (ref) => RepositoriesNotifier(ref.watch(dioProvider)),
);

class RepositoriesNotifier
    extends StateNotifier<APIResponseState<List<GitHubRepository>>>
    with APIParser {
  final Dio _dio;

  RepositoriesNotifier(this._dio) : super(APIResponseState());

  Future<void> fetchRepositories(String username) async {
    try {
      state = APIResponseState(isLoading: true);
      final response = await _dio.get('$_githubApiUrl$username/repos');
      final responseData = response.data as List<dynamic>;
      state = APIResponseState(
          data: parseList(responseData, GitHubRepository.fromJson));
    } catch (error) {
      print('Error fetching repositories: $error');
      state = APIResponseState(error: ApiError());
    }
  }
}
