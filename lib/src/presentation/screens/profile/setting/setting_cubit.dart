import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/app/app_cubit.dart';
import 'package:maybe_movie/src/domain/entities/settings/update_params.dart';
import 'package:maybe_movie/src/domain/entities/user/user.dart';
import 'package:maybe_movie/src/domain/repositories/user_repository.dart';

part 'setting_state.dart';

@Injectable()
class SettingCubit extends Cubit<SettingState> {
  SettingCubit(
    this._appCubit,
    this._userRepository,
  ) : super(const SettingState());

  final AppCubit _appCubit;
  final UserRepository _userRepository;

  void getUserParams() async {
    final user = _appCubit.state.user;
    emit(state.copyWith(
      currentUser: user,
    ));
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  Future<void> onImageChanged(File image) async {
    emit(state.copyWith(image: image));
    await _userRepository.updateImage(image);
    await _appCubit.getCurrentUser();
  }

  Future<void> updateUserInfo() async {
    final params = UpdateUserParams(
      name: state.name == "" ? state.currentUser.name : state.name,
      email: state.email == "" ? state.currentUser.email : state.email,
    );

    await _userRepository.updateParams(params);
    await _appCubit.getCurrentUser();
  }
}
