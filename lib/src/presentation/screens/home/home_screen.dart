import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/src/presentation/base/cubit/cubit_state.dart';
import 'package:maybe_movie/src/presentation/base/localization/locale_keys.g.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_widget.dart';
import 'package:maybe_movie/src/presentation/screens/home/home_cubit.dart';
import 'package:maybe_movie/src/presentation/widgets/app_bar_widget.dart';
import 'package:maybe_movie/src/presentation/widgets/basic_scaffold.dart';
import 'package:maybe_movie/src/presentation/widgets/form_field_widget.dart';
import 'package:maybe_movie/src/presentation/widgets/list_builder_widget.dart';
import 'package:maybe_movie/src/utils/logger.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const screenName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends CubitState<HomeScreen, HomeState, HomeCubit> {
  final logger = getLogger('HomeScreen');
  final TextEditingController _titleController = TextEditingController();
  final ValueKey _titleTextFieldKey = const ValueKey('titleTextFieldKey');

  @override
  void initParams(BuildContext context) {
    super.initParams(context);
    final state = cubit(context).state;

    cubit(context).getAllMovies();
    cubit(context).getUserParams();

    _titleController
      ..text = state.title
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _titleController.text.length))
      ..addListener(() {
        cubit(context).searchMovie(_titleController.text);
      });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return BasicScaffold(
      bottomBarItemIndex: 0,
      appBar: appBarWidget(context, label: LocaleKeys.tape.tr()),
      child: ErrorWrapper(
        child: observeState(
          builder: (context, state) => _buildHomeBody(context),
        ),
      ),
    );
  }

  Widget _buildHomeBody(BuildContext context) {
    return observeState(
      builder: (context, state) => state.allMovies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: FormFieldWidget(
                    key: _titleTextFieldKey,
                    controller: _titleController,
                    hintText: LocaleKeys.search_movie.tr(),
                  ),
                ),
                ListBuilderWidget(
                  listMovies: _titleController.text.isNotEmpty
                      ? state.searchedMovies
                      : state.allMovies,
                  listFavorites: state.currentUser.favoritesMoviesIds,
                  addToFavorites: (String movieId) =>
                      cubit(context).addMovieToFavorite(movieId),
                  removeFromFavorites: (String movieId) =>
                      cubit(context).removeMovieFromFavorite(movieId),
                ),
              ]),
            )),
    );
  }
}
