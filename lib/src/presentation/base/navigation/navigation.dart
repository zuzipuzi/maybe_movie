import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maybe_movie/src/app/app_cubit.dart';
import 'package:maybe_movie/src/presentation/base/cubit/host_cubit.dart';
import 'package:maybe_movie/src/presentation/screens/favorites/favorites_screen.dart';
import 'package:maybe_movie/src/presentation/screens/home/home_cubit.dart';
import 'package:maybe_movie/src/presentation/screens/home/home_screen.dart';
import 'package:maybe_movie/src/presentation/screens/auth/auth_screen.dart';
import 'package:maybe_movie/src/presentation/screens/parse/parse_cubit.dart';
import 'package:maybe_movie/src/presentation/screens/parse/parse_screen.dart';
import 'package:maybe_movie/src/presentation/screens/profile/profile_cubit.dart';
import 'package:maybe_movie/src/presentation/screens/profile/profile_screen.dart';
import 'package:maybe_movie/src/presentation/screens/profile/setting/setting_cubit.dart';
import 'package:maybe_movie/src/presentation/screens/profile/setting/setting_screen.dart';

final routerDelegate = BeamerDelegate(
  guards: [
    BeamGuard(
      pathPatterns: <String>[AuthScreen.screenName],
      guardNonMatching: true,
      check: (context, location) =>
          BlocProvider.of<AppCubit>(context).state.isUserLoggedIn,
      beamToNamed: (origin, target) => AuthScreen.screenName,
    )
  ],
  initialPath: HomeScreen.screenName,
  locationBuilder: RoutesLocationBuilder(
    routes: <String, Widget Function(BuildContext, BeamState, Object?)>{
      AuthScreen.screenName: (c, s, o) => const AuthScreen(),
      HomeScreen.screenName: (c, s, o) => const HostCubit<HomeCubit>(
            child: HomeScreen(),
          ),
      FavoritesScreen.screenName: (c, s, o) => const FavoritesScreen(),
      ProfileScreen.screenName: (c, s, o) => const HostCubit<ProfileCubit>(
            child: ProfileScreen(),
          ),
      SettingScreen.screenName: (c, s, o) => const HostCubit<SettingCubit>(
            child: SettingScreen(),
          ),
      ParseScreen.screenName: (c, s, o) =>
          const HostCubit<ParseCubit>(child: ParseScreen()),
    },
  ),
);
