import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/src/domain/entities/movie/movie.dart';
import 'package:maybe_movie/src/presentation/base/cubit/cubit_state.dart';
import 'package:maybe_movie/src/presentation/base/localization/locale_keys.g.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_widget.dart';
import 'package:maybe_movie/src/presentation/screens/home/home_screen.dart';
import 'package:maybe_movie/src/presentation/screens/movie_details/movie_details_cubit.dart';
import 'package:maybe_movie/src/presentation/widgets/app_bar_widget.dart';
import 'package:maybe_movie/src/presentation/widgets/basic_scaffold.dart';
import 'package:maybe_movie/src/utils/logger.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);

  static const screenName = '/movieDetails';

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends CubitState<MovieDetailsScreen,
    MovieDetailsState, MovieDetailsCubit> {
  final logger = getLogger('MovieDetailsScreen');

  @override
  void initParams(BuildContext context) {
    super.initParams(context);
    final movieId = Beamer.of(context).currentBeamLocation.data.toString();

    cubit(context).getMovie(movieId);
    cubit(context).getUserParams();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return BasicScaffold(
      appBar: appBarWidget(
        context,
        label: LocaleKeys.details.tr(),
        leading: _buildButtonBack(),
        actions: [_buildButtonFavorite()],
      ),
      child: ErrorWrapper(
        child: observeState(
          builder: (context, state) => _buildDetailsBody(),
        ),
      ),
    );
  }

  Widget _buildDetailsBody() {
    return observeState(
      builder: (context, state) => state.movie == mockedMovie
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  _buildTitle(),
                  const SizedBox(height: 8),
                  _buildListImages(),
                  const SizedBox(height: 8),
                  _buildGenres(),
                  const SizedBox(height: 8),
                  _buildPlot(),
                  const SizedBox(height: 8),
                  _buildActors(),
                  const SizedBox(height: 8),
                  _buildDetails(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }

  Widget _buildButtonBack() {
    final theme = Theme.of(context);
    return IconButton(
      icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
      onPressed: () {
        Beamer.of(context).beamToReplacementNamed(HomeScreen.screenName);
      },
    );
  }

  Widget _buildButtonFavorite() {
    final theme = Theme.of(context);
    return observeState(
      builder: (context, state) => IconButton(
          onPressed: () async {
            state.currentUser.favoritesMoviesIds.contains(state.movie.id)
                ? await cubit(context).removeMovieFromFavorite(state.movie.id)
                : await cubit(context).addMovieToFavorite(state.movie.id);
            logger.i(
                state.currentUser.favoritesMoviesIds.contains(state.movie.id));
          },
          icon: Icon(
            state.currentUser.favoritesMoviesIds.contains(state.movie.id)
                ? Icons.favorite
                : Icons.favorite_border,
            size: 26,
            color: theme.colorScheme.onPrimary,
          )),
    );
  }

  Widget _buildTitle() {
    final theme = Theme.of(context);
    return observeState(
        builder: (context, state) => _padding(
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  state.movie.title,
                  style: theme.textTheme.headline1!
                      .copyWith(color: theme.colorScheme.onSecondary),
                ),
                Text(state.movie.type,
                    style: theme.textTheme.headline5!.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700)),
              ]),
            ));
  }

  Widget _buildListImages() {
    return observeState(
      builder: (context, state) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: _padding(
          Row(children: [
            SizedBox(
              height: 200,
              child: ListView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.movie.images.length,
                itemBuilder: (context, index) {
                  return _buildImages(index: index);
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildImages({required int index}) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    return observeState(
      builder: (context, state) => Row(children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: theme.colorScheme.tertiary,
                    offset: const Offset(3, 0)),
                BoxShadow(
                    color: theme.colorScheme.tertiary,
                    offset: const Offset(-3, 0)),
              ]),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                  image: NetworkImage(
                state.movie.images.elementAt(index),
              ))),
        ),
        SizedBox(width: screenSize.width * 0.05)
      ]),
    );
  }

  Widget _buildGenres() {
    final theme = Theme.of(context);
    return observeState(
      builder: (context, state) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          state.movie.genre.length,
          (index) => Container(
            child: Text(state.movie.genre.elementAt(index),
                style:
                    _bodyText()!.copyWith(color: theme.colorScheme.secondary)),
            decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: theme.colorScheme.tertiary,
                      offset: const Offset(3, 3)),
                ]),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildPlot() {
    final theme = Theme.of(context);
    final onSecondary =
        _bodyText()!.copyWith(color: theme.colorScheme.onSecondary);
    final primary =
        theme.textTheme.headline3!.copyWith(color: theme.colorScheme.primary);
    return observeState(
        builder: (context, state) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${LocaleKeys.description.tr()}:', style: onSecondary),
                  Text(state.movie.plot, style: primary),
                  const SizedBox(height: 8),
                  Text('${LocaleKeys.awards.tr()}:', style: onSecondary),
                  Text(state.movie.awards, style: primary)
                ],
              ),
            ));
  }

  Widget _buildActors() {
    final theme = Theme.of(context);
    return observeState(
        builder: (context, state) => _padding(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${LocaleKeys.starring.tr()}:',
                      style: theme.textTheme.headline6!
                          .copyWith(color: theme.colorScheme.onSecondary)),
                  const SizedBox(height: 8),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    children: List.generate(
                      state.movie.actors.length,
                      (index) =>
                          Column(mainAxisSize: MainAxisSize.min, children: [
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          Container(
                            child: Text(state.movie.actors.elementAt(index),
                                style: _bodyText()!.copyWith(
                                    color: theme.colorScheme.secondary)),
                            decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: theme.colorScheme.tertiary,
                                      offset: const Offset(3, 3)),
                                ]),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 14),
                          ),
                          const SizedBox(width: 25)
                        ]),
                        const SizedBox(height: 6)
                      ]),
                    ),
                  )
                ],
              ),
            ));
  }

  Widget _buildDetails() {
    return observeState(
        builder: (context, state) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _rowText('${LocaleKeys.year.tr()}:', state.movie.year),
                  _rowText(
                      '${LocaleKeys.released.tr()}:', state.movie.released),
                  _rowText(
                      '${LocaleKeys.duration.tr()}:', state.movie.duration),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${LocaleKeys.country.tr()}:', style: _bodyText()),
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        children: List.generate(
                          state.movie.country.length,
                          (index) => Text(state.movie.country.elementAt(index),
                              style: _bodyText()),
                        ),
                      ),
                    ],
                  ),
                  _rowText(
                      '${LocaleKeys.director.tr()}:', state.movie.director),
                ],
              ),
            ));
  }

  Widget _rowText(String parameter, String state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(parameter, style: _bodyText()),
        Text(state, style: _bodyText())
      ],
    );
  }

  TextStyle? _bodyText() {
    final theme = Theme.of(context);
    return theme.textTheme.bodyText1;
  }

  Widget _padding(Widget child) {
    return Padding(padding: const EdgeInsets.only(left: 8), child: child);
  }
}
