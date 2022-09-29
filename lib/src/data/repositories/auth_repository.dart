import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/data/firebase/auth_data_source.dart';
import 'package:maybe_movie/src/data/firebase/user_data_source.dart';
import 'package:maybe_movie/src/data/mappers/firebase_error_mapper.dart';
import 'package:maybe_movie/src/domain/entities/authorization/login_params.dart';
import 'package:maybe_movie/src/domain/entities/authorization/registration_params.dart';
import 'package:maybe_movie/src/domain/repositories/authorization_repository.dart';
import 'package:maybe_movie/src/utils/logger.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(
    this._authDataSource,
    this._userDataSource,
    this._firebaseErrorMapper,
  );

  final AuthDataSource _authDataSource;
  final UserDataSource _userDataSource;
  final FirebaseErrorMapper _firebaseErrorMapper;

  final logger = getLogger('AuthRepositoryImpl');

  @override
  bool checkUserAuthStatus() {
    return _authDataSource.checkUserAuthStatus();
  }

  @override
  Future<void> logIn(LoginParams params) async {
    try {
      await _authDataSource.logIn(
        email: params.email,
        password: params.password,
      );
    } on FirebaseException catch (error) {
      throw _firebaseErrorMapper.map(error);
    } on Exception catch (error) {
      logger.e(error);
      throw Exception(error);
    }
  }

  @override
  Future<void> logInWithGoogle() async {
    try {
      final user = await _authDataSource.logInWithGoogle();
      if (!await _userDataSource.isUserExist()) {
        await _userDataSource.createUserGoogle(
          name: user!.displayName,
          image: user.photoURL,
          email: user.email!,
        );
      }
    } on FirebaseException catch (error) {
      throw _firebaseErrorMapper.map(error);
    } on Exception catch (error) {
      logger.e(error);
      throw Exception(error);
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _authDataSource.logOut();
    } on FirebaseException catch (error) {
      throw _firebaseErrorMapper.map(error);
    } on Exception catch (error) {
      logger.e(error);
      throw Exception(error);
    }
  }

  @override
  Future<void> register(RegistrationParams params) async {
    try {
      await _authDataSource.register(
        email: params.email,
        name: params.name,
        password: params.password,
      );
      await _userDataSource.createUser(
        email: params.email,
        name: params.name,
      );
    } on FirebaseException catch (error) {
      throw _firebaseErrorMapper.map(error);
    } on Exception catch (error) {
      logger.e(error);
      throw Exception(error);
    }
  }
}
