import 'package:flutter/material.dart';
import 'package:maybe_movie/src/presentation/widgets/bottom_app_bar_widget.dart';

class BasicScaffold extends StatelessWidget {
  const BasicScaffold({
    Key? key,
    required this.child,
    this.bottomBarItemIndex,
    this.withSafeArea = true,
  }) : super(key: key);

  final Widget child;
  final int? bottomBarItemIndex;
  final bool withSafeArea;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBarItemIndex != null
          ? BottomAppBarWidget(currentIndex: bottomBarItemIndex!)
          : null,
      body: withSafeArea
          ? SafeArea(
              child: child,
            )
          : child,
    );
  }
}
