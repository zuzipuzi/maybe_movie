import 'package:maybe_movie/src/domain/entities/authorization/login_params.dart';
import 'package:maybe_movie/src/domain/entities/authorization/registration_params.dart';

abstract class AuthRepository {
  Future<void> register(RegistrationParams params);

  Future<void> logIn(LoginParams login);

  Future<void> logInWithGoogle();

  bool checkUserAuthStatus();

  Future<void> logOut();
}
