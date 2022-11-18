import 'package:freezed_annotation/freezed_annotation.dart';

part 'registration_params.freezed.dart';

part 'registration_params.g.dart';

@freezed
class RegistrationParams with _$RegistrationParams {
  const factory RegistrationParams({
    required String email,
    required String name,
    required String password,
  }) = _RegistrationParams;

  factory RegistrationParams.fromJson(Map<String, dynamic> json) =>
      _$RegistrationParamsFromJson(json);
}
