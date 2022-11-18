
import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_params.freezed.dart';

@freezed
class UpdateUserParams with _$UpdateUserParams {
  const factory UpdateUserParams({
    required String name,
    required String email,

  }) = _UpdateUserParams;
}
