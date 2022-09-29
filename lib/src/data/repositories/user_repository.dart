import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/data/firebase/user_data_source.dart';
import 'package:maybe_movie/src/data/mappers/firebase_error_mapper.dart';
import 'package:maybe_movie/src/data/mappers/user_mapper.dart';
import 'package:maybe_movie/src/domain/entities/settings/setting_params.dart';
import 'package:maybe_movie/src/domain/entities/settings/update_params.dart';
import 'package:maybe_movie/src/domain/entities/user/user.dart';
import 'package:maybe_movie/src/domain/repositories/user_repository.dart';
import 'package:maybe_movie/src/utils/logger.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._userDataSource, this._firebaseErrorMapper);

  final UserDataSource _userDataSource;
  final FirebaseErrorMapper _firebaseErrorMapper;

  final logger = getLogger('UserRepository');

  @override
  Future<User> getCurrentUser() async {
    try {
      final userSnapshot = await _userDataSource.getUserInfo();
      final user = UserMapper().fromDocument(userSnapshot);
      return user;
    } on FirebaseException catch (error) {
      throw _firebaseErrorMapper.map(error);
    } on Exception catch (error) {
      logger.e(error);
      throw Exception(error);
    }
  }

  @override
  Future<void> updateParams(UpdateUserParams params) async {
    try {
      await _userDataSource.updateProfileData(
        name: params.name,
        email: params.email,
      );
    } on Exception catch (error) {
      logger.e(error);
      throw Exception();
    }
  }

  @override
  Future<void> updateSetting(SettingParams params) async {
    try {
      await _userDataSource.updateSettingData(
        theme: UserMapper().themeToString(params.theme),
        language: UserMapper().languageToString(params.language),
      );
    } on Exception catch (error) {
      logger.e(error);
      throw Exception();
    }
  }

  @override
  Future<void> updateImage(File image) async {
    try {
      await _userDataSource.updateImageData(image: image);
    } on Exception catch (error) {
      logger.e(error);
      throw Exception();
    }
  }
}
