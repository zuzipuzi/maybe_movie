import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.label,
    this.isSecondaryStyle = false,
    this.isMiniButton = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final bool isSecondaryStyle;
  final bool isMiniButton;

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme;
    final screenSize = MediaQuery.of(context).size;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSecondaryStyle ? themeColor.secondary : themeColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            56.0,
          ),
          side: BorderSide(
            color:
                isSecondaryStyle ? themeColor.onSecondary : themeColor.primary,
          ),
        ),
        fixedSize: Size(
          isMiniButton ? screenSize.width * 0.44 : screenSize.width * 0.91,
          screenSize.height * 0.06,
        ),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.headline2!.copyWith(
              color: isSecondaryStyle
                  ? themeColor.onSecondary
                  : themeColor.onPrimary,
            ),
      ),
      onPressed: onPressed,
    );
  }
}
