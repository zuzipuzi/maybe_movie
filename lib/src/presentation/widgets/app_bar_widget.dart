import 'package:flutter/material.dart';

PreferredSizeWidget appBarWidget(
  BuildContext context, {
  required String label,
  Widget? leading,
  List<Widget>? actions,
}) {
  final theme = Theme.of(context);
  return AppBar(
    leading: leading,
    actions: actions,
    centerTitle: true,
    backgroundColor: theme.colorScheme.primary,
    title: Text(
      label,
      style: theme.textTheme.headline6!
          .copyWith(color: theme.colorScheme.onPrimary),
    ),
  );
}
