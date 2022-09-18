import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/src/presentation/base/cubit/cubit_widget.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_widget.dart';
import 'package:maybe_movie/src/presentation/screens/auth/auth_screen.dart';
import 'package:maybe_movie/src/presentation/screens/home/home_cubit.dart';
import 'package:maybe_movie/src/presentation/widgets/basic_scaffold.dart';
import 'package:maybe_movie/src/presentation/widgets/button_widget.dart';

class HomeScreen extends CubitWidget<HomeState, HomeCubit> {
  const HomeScreen({Key? key}) : super(key: key);

  static const screenName = '/home';

  @override
  Widget buildWidget(BuildContext context) {
    return BasicScaffold(
      bottomBarItemIndex: 0,
      child: ErrorWrapper(
        child: observeState(
          builder: (context, state) {
            return _buildHomeBody(context);
          },
        ),
      ),
    );
  }

  Widget _buildHomeBody(BuildContext context) {
    return Center(
      child: ButtonWidget(
        onPressed: () async {
          await cubit(context).logOut();
          Beamer.of(context).beamToReplacementNamed(AuthScreen.screenName);
        },
        label: "Log out",
      ),
    );
  }
}
