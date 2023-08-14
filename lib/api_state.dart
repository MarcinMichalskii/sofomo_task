import 'package:copy_with_extension/copy_with_extension.dart';

@CopyWith()
class APIResponseState<T> {
  APIResponseState({this.isLoading = false, this.data, this.error});
  final T? data;
  final ApiError? error;
  final bool isLoading;
}

class ApiError {}
