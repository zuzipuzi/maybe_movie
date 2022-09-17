import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maybe_movie/src/domain/entities/settings/language.dart';
import 'package:maybe_movie/src/domain/entities/settings/theme.dart';

part 'setting_params.freezed.dart';

part 'setting_params.g.dart';

@freezed
class SettingParams with _$SettingParams {
  const factory SettingParams({
    required Theme theme,
    required Language language,
  }) = _SettingParams;

  factory SettingParams.fromJson(Map<String, dynamic> json) =>
      _$SettingParamsFromJson(json);
}
