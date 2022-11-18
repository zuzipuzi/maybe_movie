import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/app/app_cubit.dart';
import 'package:maybe_movie/src/domain/entities/settings/language.dart';
import 'package:maybe_movie/src/domain/entities/settings/setting_params.dart';
import 'package:maybe_movie/src/domain/entities/settings/theme.dart';
import 'package:maybe_movie/src/domain/entities/user/user.dart';
import 'package:maybe_movie/src/domain/repositories/authorization_repository.dart';
import 'package:maybe_movie/src/domain/repositories/user_repository.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_cubit.dart';
import 'package:maybe_movie/src/utils/logger.dart';

part 'profile_state.dart';

@Injectable()
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._appCubit,
    this._authRepository,
    this._errorWrapperCubit,
    this._userRepository,
  ) : super(const ProfileState());

  final AppCubit _appCubit;
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  final ErrorWrapperCubit _errorWrapperCubit;

  final logger = getLogger('ProfileCubit');

  Future<void> getUserParams() async {
    _appCubit.getCurrentUser();
    final user = _appCubit.state.user;
    emit(state.copyWith(
      currentUser: user,
    ));
  }

  Future<void> onThemeChanged(bool isThemeDark) async {
    try {
      if (isThemeDark == true) {
        emit(state.copyWith(theme: UserTheme.dark));
        final params = SettingParams(
          theme: state.theme,
          language: state.language,
        );
        await _userRepository.updateSetting(params);
        await _appCubit.getCurrentUser();
      } else {
        emit(state.copyWith(theme: UserTheme.light));
        final params = SettingParams(
          theme: state.theme,
          language: state.language,
        );
        await _userRepository.updateSetting(params);
        await _appCubit.getCurrentUser();
      }
    } on Exception catch (error) {
      logger.e(error);
    }
  }

  Future<void> logOut() async {
    try {
      _authRepository.logOut();
    } on Exception catch (error) {
      _errorWrapperCubit.processException(error);
    }
  }
}
