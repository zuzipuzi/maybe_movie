import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/data/api/api.dart';
import 'package:maybe_movie/src/domain/repositories/parse_repository.dart';
import 'package:maybe_movie/src/utils/logger.dart';

@LazySingleton(as: ParseRepository)
class ParseRepositoryImpl extends ParseRepository {
  ParseRepositoryImpl(this.movieDbApi);

  final MovieDbApi movieDbApi;

  final logger = getLogger('ParseRepository');

  @override
  Future<void> parseMovie() async {
    await movieDbApi.postMovies();
  }
}
