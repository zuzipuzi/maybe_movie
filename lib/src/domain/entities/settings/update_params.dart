import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_params.freezed.dart';

part 'update_params.g.dart';

@freezed
class UpdateUserParams with _$UpdateUserParams {
  const factory UpdateUserParams({
    required String email,
    required String name,
    required String image,
    required String password,
  }) = _UpdateUserParams;

  factory UpdateUserParams.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserParamsFromJson(json);
}
