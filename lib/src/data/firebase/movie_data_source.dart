import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/domain/entities/movie/movie.dart';
import 'package:maybe_movie/src/utils/logger.dart';

@LazySingleton()
class MovieDataSource {
  final CollectionReference _recipesCollection =
      FirebaseFirestore.instance.collection('movies');

  final logger = getLogger('MovieDataSource');

  String? get movieId =>
      FirebaseDatabase.instance.ref().child('movies').push().key;

  Future<void> postMovies(Movie movie) async {
    try {
      final dbMovie = await _recipesCollection.doc(movie.id).get();

      if (dbMovie.data() == null) {
        await _recipesCollection.doc(movie.id).set({
          'id': movie.id,
          'title': movie.title,
          'year': movie.year,
          'released': movie.released,
          'duration': movie.duration,
          "genre": movie.genre,
          "director": movie.director,
          "actors": movie.actors,
          'plot': movie.plot,
          'country': movie.country,
          'awards': movie.awards,
          'poster': movie.poster,
          'type': movie.type,
          'images': movie.images,
          'commentIds': movie.commentIds,
        });
      }
    } on Exception catch (e) {
      logger.e(e);
    }
  }
}
