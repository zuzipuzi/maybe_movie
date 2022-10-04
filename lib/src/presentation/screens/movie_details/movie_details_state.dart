part of 'movie_details_cubit.dart';

class MovieDetailsState extends Equatable {
  const MovieDetailsState({
    this.movie = mockedMovie,
    this.currentUser = mockedUser,
  });

  final Movie movie;
  final User currentUser;

  MovieDetailsState copyWith({Movie? movie, User? currentUser}) {
    return MovieDetailsState(
      movie: movie ?? this.movie,
      currentUser: currentUser ?? this.currentUser,
    );
  }

  @override
  List<Object> get props => [
        movie,
        currentUser,
      ];
}
