import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/src/app/app_cubit.dart';
import 'package:maybe_movie/src/domain/entities/settings/theme.dart';
import 'package:maybe_movie/src/presentation/base/cubit/cubit_widget.dart';
import 'package:maybe_movie/src/presentation/base/cubit/host_cubit.dart';
import 'package:maybe_movie/src/presentation/base/navigation/navigation.dart';
import 'package:maybe_movie/src/presentation/base/themes/themes.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_cubit.dart';

class MaybeMovie extends CubitWidget<AppState, AppCubit> {
  const MaybeMovie({Key? key}) : super(key: key);

  @override
  void initParams(BuildContext context) {
    super.initParams(context);
    cubit(context).isUserLoggedIn();
  }

  @override
  Widget buildWidget(BuildContext context) {
    precacheImage(const AssetImage("assets/images/logo.jpg"), context);
    return observeState(
      builder: (context, state) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        routeInformationParser: BeamerParser(),
        routerDelegate: routerDelegate,
        title: 'Maybe movie?',
        theme: state.user.theme == UserTheme.light ? Themes.light :Themes.dark,
        builder: (context, child) => HostCubit<ErrorWrapperCubit>(child: child!),
      ),
    );
  }
}
