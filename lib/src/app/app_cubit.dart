import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:maybe_movie/src/domain/repositories/authorization_repository.dart';
import 'package:maybe_movie/src/utils/logger.dart';

part 'app_state.dart';

@LazySingleton()
class AppCubit extends Cubit<AppState> {
  AppCubit(
    this._authRepository,
  ) : super(const AppState());

  final AuthRepository _authRepository;

  final logger = getLogger('AppCubit');

  Future<void> isUserLoggedIn() async {
    try {
      final isUserLoggedIn = _authRepository.checkUserAuthStatus();

      logger.i('User logged in: $isUserLoggedIn');

      emit(state.copyWith(isUserLoggedIn: isUserLoggedIn));
    } on Exception catch (error) {
      logger.e(error);
    }
  }
}
