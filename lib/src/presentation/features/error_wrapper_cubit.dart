import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:maybe_movie/src/domain/exceptions/firebase_exceptions/connection_exception.dart';
import 'package:maybe_movie/src/utils/logger.dart';

part 'error_wrapper_state.dart';

@LazySingleton()
class ErrorWrapperCubit extends Cubit<ErrorWrapperState> {
  ErrorWrapperCubit() : super(const ErrorWrapperState());

  final logger = getLogger('ErrorWrapperCubit');

  void processException(Exception exception) {
    logger.e('Process exception: $exception');

    if (exception is ConnectionException) {
      emit(state.copyWith(noInternetConnection: true));

      Timer(const Duration(seconds: 3), () {
        emit(state.copyWith(noInternetConnection: false));
      });
    } else {
      emit(state.copyWith(unknownException: true));

      Timer(const Duration(seconds: 3), () {
        emit(state.copyWith(unknownException: false));
      });
    }
  }
}
