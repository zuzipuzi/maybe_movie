import 'package:flutter/material.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_widget.dart';
import 'package:maybe_movie/src/presentation/widgets/basic_scaffold.dart';
import 'package:maybe_movie/src/presentation/widgets/button_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const screenName = '/search';

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      bottomBarItemIndex: 1,
      child: ErrorWrapper(
        child: _buildSearchBody(context),
      ),
    );
  }

  Widget _buildSearchBody(BuildContext context) {
    return Center(
      child: ButtonWidget(
        onPressed: () {},
        label: "Search",
      ),
    );
  }
}
