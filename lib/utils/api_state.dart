import 'package:copy_with_extension/copy_with_extension.dart';

@CopyWith()
class APIResponseState<T> {
  APIResponseState(
      {this.isLoading = false,
      this.data,
      this.error,
      this.isLoadingMore = false,
      this.hasMore = false,
      this.page = 1});
  final T? data;
  final ApiError? error;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final int page;
}

class ApiError {
  final String text;

  ApiError({required this.text});
}
