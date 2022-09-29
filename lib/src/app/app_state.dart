part of 'app_cubit.dart';

@immutable
class AppState extends Equatable {
  const AppState({
    this.isUserLoggedIn = false,
    this.user = mockedUser,
  });

  final User user;
  final bool isUserLoggedIn;

  AppState copyWith({
    bool? isUserLoggedIn,
    User? user,
  }) {
    return AppState(
      isUserLoggedIn: isUserLoggedIn ?? this.isUserLoggedIn,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [
        isUserLoggedIn,
        user,
      ];
}
