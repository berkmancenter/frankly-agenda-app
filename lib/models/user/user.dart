import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String name,
    required String email,
  }) = _User;

  factory UserModel.fromJson(Map<String, Object?> json) => _$UserFromJson(json);

}
