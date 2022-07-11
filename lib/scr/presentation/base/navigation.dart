import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/scr/presentation/features/home_screen.dart';

final routerDelegate = BeamerDelegate(
  guards: [
    BeamGuard(
      pathPatterns: <String>[],
      guardNonMatching: true,
      check: (context, location) => true,
    )
  ],
  initialPath: HomeScreen.screenName,
  locationBuilder: RoutesLocationBuilder(
    routes: <String, Widget Function(BuildContext, BeamState, Object?)>{},
  ),
);
