import 'package:maybe_movie/src/domain/entities/settings/setting_params.dart';
import 'package:maybe_movie/src/domain/entities/settings/update_params.dart';
import 'package:maybe_movie/src/domain/entities/user/user.dart';

abstract class UserRepository {
  Future<User> getUserInfo(String userId);

  Future<void> updateUserInfo(UpdateUserParams params);

  Future<void> updateSetting(SettingParams params);
}
