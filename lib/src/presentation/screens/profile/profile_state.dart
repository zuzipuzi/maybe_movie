part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.currentUser = mockedUser,
    this.theme = UserTheme.light,
    this.language = Language.en,
  });

  final User currentUser;
  final UserTheme theme;
  final Language language;

  ProfileState copyWith({
    User? currentUser,
    UserTheme? theme,
    Language? language,
  }) {
    return ProfileState(
      currentUser: currentUser ?? this.currentUser,
      theme: theme ?? this.theme,
      language: language ?? this.language,
    );
  }

  @override
  List<Object?> get props => [
        currentUser,
        theme,
        language,
      ];
}
