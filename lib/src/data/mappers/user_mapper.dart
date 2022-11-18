import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/domain/entities/settings/language.dart';
import 'package:maybe_movie/src/domain/entities/settings/theme.dart';
import 'package:maybe_movie/src/domain/entities/user/user.dart';

@injectable
class UserMapper {
  User fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.get('id'),
      email: doc.get('email'),
      name: doc.get('name'),
      image: doc.get('image'),
      favoritesMoviesIds:List<String>.from(doc.get('favoritesMoviesIds')),
      theme: stringToTheme(doc.get('theme')),
      language: stringToLanguage(doc.get('language')),
    );
  }

  UserTheme stringToTheme(String stringFromDoc) {
    if (stringFromDoc == 'light') {
      return UserTheme.light;
    } else {
      return UserTheme.dark;
    }
  }

  Language stringToLanguage(String stringFromDoc) {
    return Language.en;
  }

  String themeToString(UserTheme userTheme) {
    if (userTheme == UserTheme.light) {
      return 'light';
    } else {
      return 'dark';
    }
  }

  String languageToString(Language userLanguage) {
    return 'en';
  }
}
