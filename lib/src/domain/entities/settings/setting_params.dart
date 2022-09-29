import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maybe_movie/src/domain/entities/settings/language.dart';
import 'package:maybe_movie/src/domain/entities/settings/theme.dart';

part 'setting_params.freezed.dart';

@freezed
class SettingParams with _$SettingParams {
  const factory SettingParams({
    required UserTheme theme,
    required Language language,
  }) = _SettingParams;
}