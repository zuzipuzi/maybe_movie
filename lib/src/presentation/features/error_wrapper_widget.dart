import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/src/presentation/base/cubit/cubit_widget.dart';
import 'package:maybe_movie/src/presentation/base/localization/locale_keys.g.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_cubit.dart';
import 'package:maybe_movie/src/presentation/widgets/button_widget.dart';

enum ErrorWidgetType { dialog, snackBar }

class ErrorWrapper extends CubitWidget<ErrorWrapperState, ErrorWrapperCubit> {
  const ErrorWrapper({
    Key? key,
    required this.child,
    this.errorWidgetType = ErrorWidgetType.snackBar,
  }) : super(key: key);

  final Widget child;
  final ErrorWidgetType errorWidgetType;

  @override
  void onStateChanged(BuildContext context, ErrorWrapperState state) {
    if (state.noInternetConnection) {
      onError(
        title: LocaleKeys.no_internet.tr(),
        bodyText: LocaleKeys.no_internet_body.tr(),
        context: context,
      );
    } else if (state.unknownException) {
      onError(
        title: LocaleKeys.something_went_wrong.tr(),
        bodyText: LocaleKeys.something_went_wrong_body.tr(),
        context: context,
      );
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return child;
  }

  Widget _buildAlertDialog({
    required BuildContext context,
    required String title,
    required String bodyText,
  }) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
      ),
      title: Center(
        child: Text(title, textAlign: TextAlign.center),
      ),
      content: Text(
        bodyText,
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: ButtonWidget(
            onPressed: () => Navigator.pop(context),
            label: LocaleKeys.ok.tr(),
          ),
        )
      ],
    );
  }

  void onError({
    required BuildContext context,
    required String title,
    required String bodyText,
  }) {
    final theme = Theme.of(context);

    if (errorWidgetType == ErrorWidgetType.snackBar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: theme.colorScheme.primary,
          content: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: theme.colorScheme.onPrimary,
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: theme.textTheme.headline3!
                    .copyWith(color: theme.colorScheme.onPrimary),
              ),
            ],
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => _buildAlertDialog(
          title: title,
          bodyText: bodyText,
          context: context,
        ),
      );
    }
  }
}
