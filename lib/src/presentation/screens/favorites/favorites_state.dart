part of 'favorites_cubit.dart';

class FavoritesState extends Equatable {
  const FavoritesState({
    this.favoritesMovies = const [],
    this.currentUser = mockedUser,
  });

  final List<Movie> favoritesMovies;
  final User currentUser;

  FavoritesState copyWith({List<Movie>? favoritesMovies, User? currentUser}) {
    return FavoritesState(
      favoritesMovies: favoritesMovies ?? this.favoritesMovies,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  List<Object> get props => [
        favoritesMovies,
        currentUser,
      ];
}
