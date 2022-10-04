import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/data/firebase/movie_data_source.dart';
import 'package:maybe_movie/src/data/mappers/firebase_error_mapper.dart';
import 'package:maybe_movie/src/data/mappers/movie_mapper.dart';
import 'package:maybe_movie/src/domain/entities/movie/movie.dart';
import 'package:maybe_movie/src/domain/repositories/movie_repository.dart';
import 'package:maybe_movie/src/utils/logger.dart';

@LazySingleton(as: MovieRepository)
class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(this._firebaseErrorMapper, this._movieDataSource);

  final FirebaseErrorMapper _firebaseErrorMapper;
  final MovieDataSource _movieDataSource;

  final logger = getLogger('MovieRepositoryImpl');

  @override
  Future<List<Movie>> getAllMovies() async {
    try {
      final movieDocs = await _movieDataSource.getAllMovies();
      List<Movie> movies = [];
      for (var doc in movieDocs) {
        final movie = MovieMapper().fromDocument(doc);
        movies.add(movie);
      }

      return movies;
    } on FirebaseException catch (error) {
      throw _firebaseErrorMapper.map(error);
    } on Exception {
      throw Exception();
    }
  }

  @override
  Future<List<Movie>> getFavoritesMovieList(List<String> movieId) async {
    try {
      final moviesSnapshot =
          await _movieDataSource.getFavoritesMovieList(movieId);
      List<Movie> movies = [];
      for (var doc in moviesSnapshot) {
        final movie = MovieMapper().fromDocument(doc);
        movies.add(movie);
      }
      return movies;
    } on FirebaseException catch (error) {
      throw _firebaseErrorMapper.map(error);
    } on Exception catch (error) {
      logger.e(error);
      throw Exception(error);
    }
  }

  @override
  Future<Movie> getMovie(String id) async {
    try {
      final movieSnapshot = await _movieDataSource.getMovie(id);
      final movie = MovieMapper().fromDocument(movieSnapshot);
      return movie;
    } on FirebaseException catch (error) {
      throw _firebaseErrorMapper.map(error);
    } on Exception catch (error) {
      logger.e(error);
      throw Exception(error);
    }
  }

}
