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

part 'favorites_state.dart';

@Injectable()
class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this._movieRepository, this._appCubit, this._userRepository,
      this._errorWrapperCubit)
      : super(const FavoritesState());

  final MovieRepository _movieRepository;
  final AppCubit _appCubit;
  final UserRepository _userRepository;
  final ErrorWrapperCubit _errorWrapperCubit;

  final logger = getLogger('FavoritesCubit');

  Future<void> getUserParams() async {
    _appCubit.getCurrentUser();
    final user = _appCubit.state.user;
    emit(state.copyWith(
      currentUser: user,
    ));
  }

  Future<void> getFavoritesMovies() async {
    try {
      final allMovies = await _movieRepository
          .getFavoritesMovieList(state.currentUser.favoritesMoviesIds);
      emit(state.copyWith(favoritesMovies: allMovies));
    } on Exception catch (error) {
      _errorWrapperCubit.processException(error);
    }
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
      getFavoritesMovies();
    } on Exception catch (error) {
      _errorWrapperCubit.processException(error);
    }
  }
}
