import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationWidget extends StatelessWidget {
  const LocalizationWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      child: child,
      supportedLocales: const [
        Locale('en'),
      ],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
    );
  }
}
