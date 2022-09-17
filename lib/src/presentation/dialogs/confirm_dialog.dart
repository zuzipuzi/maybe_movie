import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/src/presentation/base/localization/locale_keys.g.dart';
import 'package:maybe_movie/src/presentation/widgets/button_widget.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required String title,
  required VoidCallback onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        title: Text(title, textAlign: TextAlign.center),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
        ),
        actions: [
          Column(
            children: [
              ButtonWidget(
                isMiniButton: true,
                isSecondaryStyle: true,
                onPressed: onConfirm,
                label: LocaleKeys.yes.tr(),
              ),
              const SizedBox(height: 10),
              ButtonWidget(
                isMiniButton: true,
                onPressed: () => Navigator.pop(context),
                label: LocaleKeys.no.tr(),
              ),
            ],
          ),
        ],
      );
    },
  );
}
