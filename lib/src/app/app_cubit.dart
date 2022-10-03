import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/domain/entities/user/user.dart';
import 'package:maybe_movie/src/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:maybe_movie/src/domain/repositories/authorization_repository.dart';
import 'package:maybe_movie/src/utils/logger.dart';

part 'app_state.dart';

@LazySingleton()
class AppCubit extends Cubit<AppState> {
  AppCubit(
    this._authRepository,
    this._userRepository,
  ) : super(const AppState());

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  final logger = getLogger('AppCubit');

  Future<void> isUserLoggedIn() async {
    try {
      final isUserLoggedIn = _authRepository.checkUserAuthStatus();

      logger.i('User logged in: $isUserLoggedIn');

      emit(state.copyWith(isUserLoggedIn: isUserLoggedIn));
      if (isUserLoggedIn) {
        getCurrentUser();
        logger.i(state.user);
      }
    } on Exception catch (error) {
      logger.e(error);
    }
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await _userRepository.getCurrentUser();

      emit(state.copyWith(user: user));
    } on Exception catch (error) {
      logger.e(error);
    }
  }
}
