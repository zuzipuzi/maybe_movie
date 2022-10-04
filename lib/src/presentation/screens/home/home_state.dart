part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.allMovies = const [],
    this.currentUser = mockedUser,
    this.title = "",
    this.searchedMovies = const [],
  });

  final List<Movie> allMovies;
  final User currentUser;
  final String title;
  final List<Movie> searchedMovies;

  HomeState copyWith({
    List<Movie>? allMovies,
    User? currentUser,
    String? title,
    List<Movie>? searchedMovies,
  }) {
    return HomeState(
      allMovies: allMovies ?? this.allMovies,
      currentUser: currentUser ?? this.currentUser,
      title: title ?? this.title,
      searchedMovies: searchedMovies ?? this.searchedMovies,
    );
  }

  @override
  List<Object> get props => [
        allMovies,
        currentUser,
        title,
        searchedMovies,
      ];
}
