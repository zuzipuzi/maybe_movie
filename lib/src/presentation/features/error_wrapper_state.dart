part of 'error_wrapper_cubit.dart';

@immutable
class ErrorWrapperState extends Equatable {
  const ErrorWrapperState({
    this.noInternetConnection = false,
    this.unknownException = false,
  });

  final bool noInternetConnection;
  final bool unknownException;

  ErrorWrapperState copyWith({
    bool? noInternetConnection,
    bool? unknownException,
  }) {
    return ErrorWrapperState(
      noInternetConnection: noInternetConnection ?? this.noInternetConnection,
      unknownException: unknownException ?? this.unknownException,
    );
  }

  @override
  List<Object?> get props => [
        noInternetConnection,
        unknownException,
      ];
}
