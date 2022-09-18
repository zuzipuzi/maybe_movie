part of 'app_cubit.dart';

@immutable
class AppState extends Equatable {
  const AppState({
    this.isUserLoggedIn = false,
  });

  final bool isUserLoggedIn;

  AppState copyWith({
    bool? isUserLoggedIn,
  }) {
    return AppState(
      isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
    );
  }

  @override
  List<Object?> get props => [isUserLoggedIn];
}
