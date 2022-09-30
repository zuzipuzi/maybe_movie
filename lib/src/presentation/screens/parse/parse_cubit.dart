import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:maybe_movie/src/domain/repositories/parse_repository.dart';

part 'parse_state.dart';

@Injectable()
class ParseCubit extends Cubit<ParseState> {
  ParseCubit(this._parseRepository) : super(ParseState());

  final ParseRepository _parseRepository;

  Future<void> parseMovie() async {
    _parseRepository.parseMovie();
  }
}