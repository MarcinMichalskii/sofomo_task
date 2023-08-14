import 'dart:convert';

mixin APIParser {
  T parseItem<T>(String data, T Function(Map<String, dynamic> data) fromJson) {
    final items = json.decode(data) as Map<String, dynamic>;
    return fromJson(items);
  }

  List<T> parseList<T>(
      List<dynamic> data, T Function(Map<String, dynamic> data) fromJson) {
    try {
      return data
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList(growable: false);
    } catch (e) {
      print(e);
      return [];
    }
  }
}
