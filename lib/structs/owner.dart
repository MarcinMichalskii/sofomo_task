import 'package:freezed_annotation/freezed_annotation.dart';
part 'owner.g.dart';

@JsonSerializable()
class Owner {
  final String login;

  Owner({required this.login});

  factory Owner.fromJson(Map<String, dynamic> json) => _$OwnerFromJson(json);
}
