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

part 'home_state.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._movieRepository, this._appCubit, this._userRepository,
      this._errorWrapperCubit)
      : super(const HomeState());

  final MovieRepository _movieRepository;
  final AppCubit _appCubit;
  final UserRepository _userRepository;
  final ErrorWrapperCubit _errorWrapperCubit;

  final logger = getLogger('HomeCubit');

  Future<void> getAllMovies() async {
    try {
      final allMovies = await _movieRepository.getAllMovies();
      emit(state.copyWith(allMovies: allMovies));
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

  Future<void> searchMovie(String title) async {
    try {
      List<Movie> movies = [];
      for (var movie in state.allMovies) {
        if (movie.title.toLowerCase().contains(title.toLowerCase())) {
          movies.add(movie);
        }
      }

      emit(state.copyWith(searchedMovies: movies));
    } on Exception catch (error) {
      _errorWrapperCubit.processException(error);
    }
  }
}
