import 'package:flutter/material.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_widget.dart';
import 'package:maybe_movie/src/presentation/widgets/basic_scaffold.dart';
import 'package:maybe_movie/src/presentation/widgets/button_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const screenName = '/profile';

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      bottomBarItemIndex: 3,
      child: ErrorWrapper(
        child: _buildProfileBody(context),
      ),
    );
  }

  Widget _buildProfileBody(BuildContext context) {
    return Center(
      child: ButtonWidget(
        onPressed: () {},
        label: "Profile",
      ),
    );
  }
}
