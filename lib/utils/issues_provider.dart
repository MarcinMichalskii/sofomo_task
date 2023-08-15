import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sofomo_task/structs/github_issue.dart';
import 'package:sofomo_task/utils/api_parser.dart';
import 'package:sofomo_task/utils/api_state.dart';
import 'package:sofomo_task/utils/dio_provider.dart';
import 'package:sofomo_task/utils/texts.dart';

final issuesProvider = StateNotifierProvider<RepositoryIssuesNotifier,
    APIResponseState<List<GitHubIssue>>>(
  (ref) => RepositoryIssuesNotifier(ref.watch(dioProvider)),
);

class RepositoryIssuesNotifier
    extends StateNotifier<APIResponseState<List<GitHubIssue>>> with APIParser {
  final Dio _dio;

  RepositoryIssuesNotifier(this._dio) : super(APIResponseState());

  String _urlForId(int id) {
    return 'https://api.github.com/repositories/$id/issues';
  }

  Future<void> fetch(int id) async {
    try {
      state = APIResponseState(isLoading: true);
      final response = await _dio.get(_urlForId(id), queryParameters: {
        'state': 'open',
        'per_page': 50,
      });
      final parsedList = parseList(response.data, GitHubIssue.fromJson);
      state =
          APIResponseState(data: parsedList, hasMore: parsedList.length == 50);
    } catch (error) {
      state = APIResponseState(error: ApiError(text: Texts.somethingWentWrong));
    }
  }

  Future<void> fetchMore(
    int id,
  ) async {
    try {
      state = APIResponseState(
          data: state.data,
          isLoadingMore: true,
          isLoading: false,
          page: state.page);
      final response = await _dio.get(_urlForId(id), queryParameters: {
        'page': state.page + 1,
        'per_page': 50,
        'state': 'open'
      });
      final newPage = state.page + 1;
      final parsed = parseList(response.data, GitHubIssue.fromJson);

      state = APIResponseState(
          data: (state.data ?? []) + parsed,
          page: newPage,
          isLoading: false,
          isLoadingMore: false,
          hasMore: parsed.length == 50);
    } catch (error) {
      state = APIResponseState(error: ApiError(text: Texts.somethingWentWrong));
    }
  }
}
