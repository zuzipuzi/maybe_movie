import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maybe_movie/src/app/app.dart';
import 'package:maybe_movie/src/app/app_cubit.dart';
import 'package:maybe_movie/src/di/di_host.dart';
import 'package:maybe_movie/src/presentation/base/cubit/host_cubit.dart';
import 'package:maybe_movie/src/presentation/base/localization/localization_widget.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) {
      runApp(
        const LocalizationWidget(
          child: DIHost(
            child: HostCubit<AppCubit>(
              child: MaybeMovie(),
            ),
          ),
        ),
      );
    },
  );
}
