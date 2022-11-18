import 'dart:io';

import 'package:maybe_movie/src/domain/entities/settings/setting_params.dart';
import 'package:maybe_movie/src/domain/entities/settings/update_params.dart';
import 'package:maybe_movie/src/domain/entities/user/user.dart';

abstract class UserRepository {
  Future<User> getCurrentUser();

  Future<void> updateParams(UpdateUserParams params);

  Future<void> updateSetting(SettingParams params);

  Future<void> updateImage(File image);

  Future<void> addMovieToFavorite(List <String> movieId);

  Future<void> removeMovieFromFavorite(List <String> movieId);
}
