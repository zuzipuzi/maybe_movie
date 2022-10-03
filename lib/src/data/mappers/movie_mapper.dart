import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/domain/entities/movie/movie.dart';

@injectable
class MovieMapper {
  Movie fromDocument(DocumentSnapshot doc) {
    return Movie(
      id: doc.get('id'),
      title: doc.get('title'),
      year: doc.get('year'),
      released: doc.get('released'),
      duration: doc.get('duration'),
      genre: List<String>.from(doc.get('genre')),
      director: doc.get('director'),
      actors: List<String>.from(doc.get('actors')),
      plot: doc.get('plot'),
      country: List<String>.from(doc.get('country')),
      awards: doc.get('awards'),
      poster: doc.get('poster'),
      type: doc.get('type'),
      images: List<String>.from(doc.get('images')),
      commentIds: List<String>.from(doc.get('commentIds')),
    );
  }
}
