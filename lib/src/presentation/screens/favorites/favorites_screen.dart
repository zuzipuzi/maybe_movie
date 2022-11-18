import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/src/presentation/base/cubit/cubit_state.dart';
import 'package:maybe_movie/src/presentation/base/localization/locale_keys.g.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_widget.dart';
import 'package:maybe_movie/src/presentation/screens/favorites/favorites_cubit.dart';
import 'package:maybe_movie/src/presentation/widgets/app_bar_widget.dart';
import 'package:maybe_movie/src/presentation/widgets/basic_scaffold.dart';
import 'package:maybe_movie/src/presentation/widgets/list_builder_widget.dart';
import 'package:maybe_movie/src/utils/logger.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  static const screenName = '/favorites';

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState
    extends CubitState<FavoritesScreen, FavoritesState, FavoritesCubit> {
  final logger = getLogger('FavoritesScreen');

  @override
  void initParams(BuildContext context) {
    super.initParams(context);
    cubit(context).getUserParams();
    cubit(context).getFavoritesMovies();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return BasicScaffold(
      bottomBarItemIndex: 1,
      appBar: appBarWidget(context, label: LocaleKeys.favorites.tr()),
      child: ErrorWrapper(
        child: observeState(
          builder: (context, state) => _buildFavoritesBody(),
        ),
      ),
    );
  }

  Widget _buildFavoritesBody() {
    return observeState(
        builder: (context, state) => state.favoritesMovies.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: ListBuilderWidget(
                  listMovies: state.favoritesMovies,
                  listFavorites: state.currentUser.favoritesMoviesIds,
                  addToFavorites: (String movieId) =>
                      cubit(context).addMovieToFavorite(movieId),
                  removeFromFavorites: (String movieId) =>
                      cubit(context).removeMovieFromFavorite(movieId),
                ),
              ));
  }
}
