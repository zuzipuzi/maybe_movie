import 'package:maybe_movie/src/domain/entities/movie/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getAllMovies();


  Future<List<Movie>> getFavoritesMovieList(List<String> movieId);

  Future<Movie> getMovie(String id);
}
