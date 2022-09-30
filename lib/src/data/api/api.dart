import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/data/firebase/movie_data_source.dart';
import 'package:maybe_movie/src/domain/entities/movie/movie.dart';
import 'package:maybe_movie/src/utils/logger.dart';

@LazySingleton()
class MovieDbApi {
  MovieDbApi(
    this._movieDataSource,
  );

  final MovieDataSource _movieDataSource;

  static const body =
      'https://gist.githubusercontent.com/mkiisoft/91e0a8d144864d5feced755e1511b1e5/raw/2e4dd8ca2470102394a0f3084fc52672151a1f7a/movies.json';

  final logger = getLogger('MovieDBApi');

  Future<void> postMovies() async {
    final movies = await getMovies();

    for (var movie in movies) {
      _movieDataSource.postMovies(movie);
    }
  }

  Future<List<Movie>> getMovies() async {
    final url = Uri.parse(body);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body) as List<dynamic>;

      logger.i(response.body);
      List<Movie> movies = [];
      for (var movie in responseBody) {
        if (mapToMovie(movie) != null) {
          movies.add(mapToMovie(movie)!);
        }
      }
      return movies;
    } else {
      throw Exception('Error');
    }
  }

  Movie? mapToMovie(Map<String, dynamic> movie) {
    return Movie(
      id: movie['imdbID'],
      title: movie['Title'],
      year: movie['Year'],
      released: movie['Released'],
      duration: movie['Runtime'],
      genre: parseGenres(movie),
      director: movie['Director'],
      actors: parseActors(movie),
      plot: movie['Plot'],
      country: parseCountries(movie),
      awards: movie['Awards'],
      poster: movie['Poster'],
      type: movie['Type'],
      images: parseImages(movie),
      commentIds: [],
    );
  }

  List<String> parseGenres(Map<String, dynamic> movie) {
    final String? apiGenres = movie['Genre'];

    List<String> genres = [];

    if (apiGenres != null) {
      genres = apiGenres.split(',');
      return genres;
    }

    return [];
  }

  List<String> parseActors(Map<String, dynamic> movie) {
    final String? apiActors = movie['Actors'];

    List<String> actors = [];

    if (apiActors != null) {
      actors = apiActors.split(',');
      return actors;
    }

    return [];
  }

  List<String> parseCountries(Map<String, dynamic> movie) {
    final String? apiCountries = movie['Country'];

    List<String> countries = [];

    if (apiCountries != null) {
      countries = apiCountries.split(',');
      return countries;
    }

    return [];
  }

  List<String> parseImages(Map<String, dynamic> movie) {
    final  List<dynamic> apiImages = movie['Images'];

    List<String> images = [];

    for (var apiImage in apiImages) {
     images.add(apiImage.toString());

    }
    return images;
  }
}
