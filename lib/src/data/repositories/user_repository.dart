import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/domain/entities/settings/setting_params.dart';
import 'package:maybe_movie/src/domain/entities/settings/update_params.dart';
import 'package:maybe_movie/src/domain/entities/user/user.dart';
import 'package:maybe_movie/src/domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryDB implements UserRepository {
  @override
  Future<User> getUserInfo(String userId) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateSetting(SettingParams params) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateUserInfo(UpdateUserParams params) {
    throw UnimplementedError();
  }
}
