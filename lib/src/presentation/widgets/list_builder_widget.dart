import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/src/domain/entities/movie/movie.dart';
import 'package:maybe_movie/src/presentation/screens/movie_details/movie_details_screen.dart';

class ListBuilderWidget extends StatelessWidget {
  const ListBuilderWidget(
      {Key? key,
      required this.listMovies,
      required this.listFavorites,
      required this.addToFavorites,
      required this.removeFromFavorites})
      : super(key: key);

  final List<Movie> listMovies;
  final List<String> listFavorites;
  final Function(String movieId) addToFavorites;
  final Function(String movieId) removeFromFavorites;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listMovies.length,
      itemBuilder: (context, index) => _buildMoviesCards(
        context,
        movie: listMovies.elementAt(index),
      ),
    );
  }

  Widget _buildMoviesCards(BuildContext context, {required Movie movie}) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size; //752 i 360

    return Stack(children: [
      GestureDetector(
        child: Card(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: screenSize.height * 0.266,
                  width: screenSize.width * 0.389,
                  child: Image(image: NetworkImage(movie.poster)),
                ),
                SizedBox(
                    width: screenSize.width * 0.555,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headline6!
                              .copyWith(color: theme.colorScheme.onSecondary),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          movie.year,
                          style: theme.textTheme.subtitle1!
                              .copyWith(color: theme.colorScheme.primary),
                        ),
                        _listGenerate(context, false, parameter: movie.genre),
                        const SizedBox(height: 5),
                        _listGenerate(context, true, parameter: movie.actors),
                      ],
                    )),
              ]),
        ),
        onTap: () {
          Beamer.of(context).beamToNamed(MovieDetailsScreen.screenName,
              data:movie.id);
        },
      ),
      Positioned(
        bottom: 10,
        right: 10,
        child: IconButton(
            onPressed: () async => listFavorites.contains(movie.id)
                ? await removeFromFavorites(movie.id)
                : await addToFavorites(movie.id),
            icon: Icon(
              listFavorites.contains(movie.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
              size: 26,
              color: theme.colorScheme.primary,
            )),
      ),
    ]);
  }

  Widget _listGenerate(BuildContext context, bool actors,
      {required List<String> parameter}) {
    final theme = Theme.of(context);
    return Wrap(
      children: List.generate(
        parameter.length,
        (index) => Text(parameter.elementAt(index),
            style: actors
                ? theme.textTheme.subtitle1!
                    .copyWith(color: theme.colorScheme.onSecondary)
                : theme.textTheme.headline3!
                    .copyWith(color: theme.colorScheme.onSecondary)),
      ),
    );
  }
}
