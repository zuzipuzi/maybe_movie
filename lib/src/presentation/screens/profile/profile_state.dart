part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.currentUser = mockedUser,
    this.userLoading = true,
    this.theme = UserTheme.light,
    this.language = Language.en,
  });

  final User currentUser;
  final bool userLoading;
  final UserTheme theme;
  final Language language;

  ProfileState copyWith({
    User? currentUser,
    bool? userLoading,
    UserTheme? theme,
    Language? language,
  }) {
    return ProfileState(
      currentUser: currentUser ?? this.currentUser,
      userLoading: userLoading ?? this.userLoading,
      theme: theme ?? this.theme,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [
        currentUser,
        userLoading,
        theme,
        language,
      ];
}
