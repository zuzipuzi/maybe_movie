import 'package:flutter/material.dart';
import 'package:maybe_movie/src/presentation/base/cubit/cubit_state.dart';
import 'package:maybe_movie/src/presentation/screens/parse/parse_cubit.dart';
import 'package:maybe_movie/src/utils/logger.dart';

class ParseScreen extends StatefulWidget {
  const ParseScreen({Key? key}) : super(key: key);

  static const screenName = '/parse';

  @override
  State<ParseScreen> createState() => _ParseScreenState();
}

class _ParseScreenState
    extends CubitState<ParseScreen, ParseState, ParseCubit> {
  final logger = getLogger('ProfileScreen');

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: cubit(context).parseMovie,
          child: const Text('Parse API to DB'),
        ),
      ),
    );
  }
}
