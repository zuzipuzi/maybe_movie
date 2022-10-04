import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class MovieDataSource {
  MovieDataSource();

  final CollectionReference _moviesCollection =
      FirebaseFirestore.instance.collection('movies');

  Future<DocumentSnapshot> getMovie(String id) async {
    final movieSnapshot = await _moviesCollection.doc(id).get();
    return movieSnapshot;
  }

  Future<List<DocumentSnapshot>> getAllMovies() async {
    List<DocumentSnapshot> movies = [];

    final allMovie = await _moviesCollection.get();
    for (var doc in allMovie.docs) {
      movies.add(doc);
    }
    return movies;
  }

  Future<List<DocumentSnapshot>> getFavoritesMovieList(
      List<String> movieId) async {
    List<DocumentSnapshot> movies = [];

    for (var id in movieId) {
      final movieSnapshot = await _moviesCollection.doc(id).get();
      movies.add(movieSnapshot);
    }

    return movies;
  }

}
