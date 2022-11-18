import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:maybe_movie/src/domain/entities/settings/language.dart';
import 'package:maybe_movie/src/domain/entities/settings/theme.dart';

part 'user.freezed.dart';

part 'user.g.dart';

const mockedUser = User(
  id: '1',
  email: 'email',
  name: 'name',
  image: '',
  favoritesMoviesIds: [],
  theme: UserTheme.light,
  language: Language.en,
);

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String name,
    required String image,
    required List<String> favoritesMoviesIds,
    required UserTheme theme,
    required Language language,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
