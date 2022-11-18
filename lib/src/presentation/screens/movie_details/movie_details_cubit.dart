import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:maybe_movie/src/app/app_cubit.dart';
import 'package:maybe_movie/src/domain/entities/movie/movie.dart';
import 'package:maybe_movie/src/domain/entities/user/user.dart';
import 'package:maybe_movie/src/domain/repositories/movie_repository.dart';
import 'package:maybe_movie/src/domain/repositories/user_repository.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_cubit.dart';
import 'package:maybe_movie/src/utils/logger.dart';

part 'movie_details_state.dart';

@Injectable()
class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit(this._movieRepository, this._appCubit, this._userRepository,
      this._errorWrapperCubit)
      : super(const MovieDetailsState());

  final MovieRepository _movieRepository;
  final AppCubit _appCubit;
  final UserRepository _userRepository;
  final ErrorWrapperCubit _errorWrapperCubit;

  final logger = getLogger('MovieDetailsCubit');

  Future<void> getMovie(String movieId) async {
    try {
      final movie = await _movieRepository.getMovie(movieId);
      emit(state.copyWith(movie: movie));
    } on Exception catch (error) {
      _errorWrapperCubit.processException(error);
    }
  }

  Future<void> getUserParams() async {
    _appCubit.getCurrentUser();
    final user = _appCubit.state.user;
    emit(state.copyWith(
      currentUser: user,
    ));
  }

  Future<void> addMovieToFavorite(String movieId) async {
    try {
      List<String> listFavorites =
          List.from(state.currentUser.favoritesMoviesIds);

      listFavorites.add(movieId);

      await _userRepository.addMovieToFavorite(listFavorites);
      await _appCubit.getCurrentUser();
      emit(state.copyWith(
          currentUser:
              state.currentUser.copyWith(favoritesMoviesIds: listFavorites)));
    } on Exception catch (error) {
      _errorWrapperCubit.processException(error);
    }
  }

  Future<void> removeMovieFromFavorite(String movieId) async {
    try {
      List<String> listFavorites =
          List.from(state.currentUser.favoritesMoviesIds);

      listFavorites.remove(movieId);

      await _userRepository.removeMovieFromFavorite(listFavorites);
      await _appCubit.getCurrentUser();
      emit(state.copyWith(
          currentUser:
              state.currentUser.copyWith(favoritesMoviesIds: listFavorites)));
    } on Exception catch (error) {
      _errorWrapperCubit.processException(error);
    }
  }
}
