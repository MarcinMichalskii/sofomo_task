import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofomo_task/structs/github_repository.dart';
import 'package:sofomo_task/utils/api_parser.dart';
import 'package:sofomo_task/utils/api_state.dart';
import 'package:sofomo_task/utils/dio_provider.dart';
import 'package:sofomo_task/utils/texts.dart';

const String baseRepoUrl = 'https://api.github.com/search/repositories';

final repositoriesProvider = StateNotifierProvider<RepositoriesNotifier,
    APIResponseState<List<GitHubRepository>>>(
  (ref) => RepositoriesNotifier(ref.watch(dioProvider)),
);

class RepositoriesNotifier
    extends StateNotifier<APIResponseState<List<GitHubRepository>>>
    with APIParser {
  final Dio _dio;

  RepositoriesNotifier(this._dio) : super(APIResponseState());

  Map<String, dynamic> _queryParams(String keywords, int page) {
    return {'in': 'name', 'q': keywords, 'page': 1, 'per_page': 50};
  }

  Future<void> fetchRepositories(String keywords) async {
    try {
      state = APIResponseState(isLoading: true);
      final response = await _dio.get(baseRepoUrl,
          queryParameters: _queryParams(keywords, 1));
      final responseData = response.data as Map<String, dynamic>;
      final responseItems =
          parseList(responseData['items'], GitHubRepository.fromJson);
      state = APIResponseState(
          data: parseList(responseData['items'], GitHubRepository.fromJson),
          hasMore: responseItems.length == 50);
    } catch (error) {
      state = APIResponseState(error: ApiError(text: Texts.somethingWentWrong));
    }
  }

  Future<void> fetchMore(
    String keywords,
  ) async {
    try {
      state = APIResponseState(
          data: state.data,
          isLoadingMore: true,
          isLoading: false,
          page: state.page);
      final response = await _dio.get(baseRepoUrl,
          queryParameters: _queryParams(keywords, state.page + 1));
      final responseData = response.data as Map<String, dynamic>;
      final receivedItems =
          parseList(responseData['items'], GitHubRepository.fromJson);
      final newData = (state.data ?? []) + receivedItems;
      final newPage = state.page + 1;

      state = APIResponseState(
          data: newData,
          page: newPage,
          isLoading: false,
          isLoadingMore: false,
          hasMore: receivedItems.length == 50);
    } catch (error) {
      state = APIResponseState(error: ApiError(text: Texts.somethingWentWrong));
    }
  }
}
