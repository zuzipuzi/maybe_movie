import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';

part 'movie.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class Movie with _$Movie {
  const Movie._();

  @JsonSerializable(explicitToJson: true)
  const factory Movie({
    required String id,
    required String title,
    required String year,
    required String released,
    required String duration,
    required List<String> genre,
    required String director,
    required List<String> actors,
    required String plot,
    required List<String> country,
    required String awards,
    required String poster,
    required String type,
    required List<String> images,
    required List<String> commentIds,
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
