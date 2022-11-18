import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/app/app_cubit.dart';
import 'package:maybe_movie/src/domain/entities/authorization/login_params.dart';
import 'package:maybe_movie/src/domain/entities/authorization/registration_params.dart';
import 'package:maybe_movie/src/domain/exceptions/firebase_exceptions/email_exist_exception.dart';
import 'package:maybe_movie/src/domain/exceptions/firebase_exceptions/invalid_email_exception.dart';
import 'package:maybe_movie/src/domain/exceptions/firebase_exceptions/invalid_password_exception.dart';
import 'package:maybe_movie/src/domain/exceptions/firebase_exceptions/user_not_found_exception.dart';
import 'package:maybe_movie/src/domain/repositories/authorization_repository.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_cubit.dart';
import 'package:maybe_movie/src/utils/logger.dart';
import 'package:maybe_movie/src/utils/validators.dart';

part 'auth_state.dart';

@Injectable()
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(
      this._authRepository,
    this._appCubit,
    this._errorWrapperCubit,
  ) : super(const AuthState());

 final AuthRepository _authRepository;

  final AppCubit _appCubit;
  final ErrorWrapperCubit _errorWrapperCubit;

  final logger = getLogger('AuthCubit');

  void _checkAllFieldsFilled({required bool isRegistration}) {
    isRegistration
        ? emit(
            state.copyWith(
              allFieldsFilled: state.email.isNotEmpty &&
                  state.name.isNotEmpty &&
                  state.password.isNotEmpty &&
                  state.confirmedPassword.isNotEmpty,
            ),
          )
        : emit(
            state.copyWith(
              allFieldsFilled:
                  state.email.isNotEmpty && state.password.isNotEmpty,
            ),
          );
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(
      email: email,
      invalidEmail: false,
      emailAlreadyUsed: false,
    ));
    _checkAllFieldsFilled(isRegistration: false);
  }

  void onNameChanged(String name) {
    emit(state.copyWith(
      name: name,
      invalidEmail: false,
    ));

    _checkAllFieldsFilled(isRegistration: true);
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(
      password: password,
      invalidPassword: false,
    ));
    _checkAllFieldsFilled(isRegistration: false);
  }

  void onRepeatedPasswordChanged(String confirmedPassword) {
    emit(state.copyWith(
      confirmedPassword: confirmedPassword,
      invalidConfirmedPassword: false,
    ));
    _checkAllFieldsFilled(isRegistration: true);
  }

  Future<void> register() async {
    final emailValid = validateEmail(state.email);
    final nameValid = validateName(state.name);
    final passwordValid = validatePassword(state.password);
    final confirmedPasswordValid = validateConfirmedPassword(
      password: state.password,
      confirmedPassword: state.confirmedPassword,
    );

    _checkAllFieldsFilled(isRegistration: true);
    if (emailValid && nameValid && passwordValid && confirmedPasswordValid) {
      try {
        final params = RegistrationParams(
          email: state.email,
          name: state.name,
          password: state.password,
        );

        logger.i(params);

        await _authRepository.register(params);

        await _appCubit.isUserLoggedIn();

        emit(state.copyWith(allIsValid: true));

        logger.i(state.allIsValid);
      } on EmailAlreadyExistException catch (error) {
        emit(state.copyWith(emailAlreadyUsed: true));
        logger.e(error);
      } on InvalidEmailException catch (error) {
        emit(state.copyWith(invalidEmail: true));
        logger.e(error);
      } on InvalidPasswordException catch (error) {
        emit(state.copyWith(invalidPassword: true));
        logger.e(error);
      } on Exception catch (error) {
        _errorWrapperCubit.processException(error);
      }
    } else {
      emit(
        state.copyWith(
          invalidEmail: !emailValid,
          invalidName: !nameValid,
          invalidPassword: !passwordValid,
          invalidConfirmedPassword: !confirmedPasswordValid,
        ),
      );
    }
  }

  Future<void> logIn() async {
    final emailValid = validateEmail(state.email);

    final passwordValid = validatePassword(state.password);

    _checkAllFieldsFilled(isRegistration: false);
    if (emailValid && passwordValid) {
      try {
        final params = LoginParams(
          email: state.email,
          password: state.password,
        );

        logger.i(params);

        await _authRepository.logIn(params);

        await _appCubit.isUserLoggedIn();

        emit(state.copyWith(allIsValid: true));
      } on InvalidEmailException catch (error) {
        emit(state.copyWith(invalidEmail: true));
        logger.e(error);
      } on UserNotFoundException catch (error) {
        emit(state.copyWith(userNotFound: true));
        logger.e(error);
      } on Exception catch (error) {
        _errorWrapperCubit.processException(error);
      }
    } else {
      emit(
        state.copyWith(
          invalidEmail: !emailValid,
          invalidPassword: !passwordValid,
        ),
      );
    }
  }

  Future<void> logInGoogle() async {
    try {
      await _authRepository.logInWithGoogle();

      await _appCubit.isUserLoggedIn();

      emit(state.copyWith(allIsValid: true));
    } on Exception catch (error) {
      _errorWrapperCubit.processException(error);
    }
  }
}
