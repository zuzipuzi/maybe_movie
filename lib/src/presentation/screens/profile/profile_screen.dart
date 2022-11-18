import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/src/domain/entities/user/user.dart';
import 'package:maybe_movie/src/presentation/base/cubit/cubit_state.dart';
import 'package:maybe_movie/src/presentation/base/localization/locale_keys.g.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_widget.dart';
import 'package:maybe_movie/src/presentation/screens/auth/auth_screen.dart';
import 'package:maybe_movie/src/presentation/screens/profile/profile_cubit.dart';
import 'package:maybe_movie/src/presentation/screens/profile/setting/setting_screen.dart';
import 'package:maybe_movie/src/presentation/widgets/app_bar_widget.dart';
import 'package:maybe_movie/src/presentation/widgets/basic_scaffold.dart';
import 'package:maybe_movie/src/presentation/widgets/button_widget.dart';
import 'package:maybe_movie/src/utils/logger.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const screenName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState
    extends CubitState<ProfileScreen, ProfileState, ProfileCubit> {
  final logger = getLogger('ProfileScreen');

  @override
  void initParams(BuildContext context) {
    super.initParams(context);
    if (cubit(context).state.currentUser == mockedUser) {
      cubit(context).getUserParams();
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return BasicScaffold(
      appBar: appBarWidget(
        context,
        label: LocaleKeys.profile.tr(),
        actions: [_buildSettingButton()],
      ),
      bottomBarItemIndex: 2,
      child: ErrorWrapper(
        child: observeState(
          builder: (context, state) => _buildProfileBody(),
        ),
      ),
    );
  }

  Widget _buildProfileBody() {
    final screenSize = MediaQuery.of(context).size;
    return observeState(
        builder: (context, state) => state.currentUser == mockedUser
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildImage(state),
                    const SizedBox(height: 20),
                    _buildName(state),
                    const SizedBox(height: 50),
                    _buildTheme(state),
                    SizedBox(height: screenSize.height * 0.25),
                    _buildLogOut(),
                  ],
                ),
              ));
  }

  Widget _buildSettingButton() {
    final theme = Theme.of(context);
    return IconButton(
        onPressed: () {
          Beamer.of(context).beamToReplacementNamed(SettingScreen.screenName);
        },
        icon: Icon(Icons.settings, color: theme.colorScheme.onPrimary));
  }

  Widget _buildImage(ProfileState state) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: theme.colorScheme.onTertiary, width: 1),
            color: theme.colorScheme.onPrimary),
        child: state.currentUser.image != ''
            ? CircleAvatar(
                backgroundImage: NetworkImage(state.currentUser.image),
                radius: 50,
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: const Image(
                  image: AssetImage("assets/images/avatar.png"),
                  fit: BoxFit.fill,
                ),
              ),
      ),
    );
  }

  Widget _buildName(ProfileState state) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          state.currentUser.name,
          style: theme.textTheme.headline4!
              .copyWith(color: theme.colorScheme.onSecondary),
        ),
        Text(
          state.currentUser.email,
          style: theme.textTheme.bodyText1!
              .copyWith(color: theme.colorScheme.primary),
        ),
      ],
    );
  }

  Widget _buildTheme(ProfileState state) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.tertiary,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ButtonWidget(
            isMiniButton: true,
            onPressed: () async {
              await cubit(context).onThemeChanged(true);
            },
            label: LocaleKeys.dark.tr()),
        ButtonWidget(
            isMiniButton: true,
            onPressed: () async {
              await cubit(context).onThemeChanged(false);
            },
            label: LocaleKeys.light.tr()),
      ]),
    );
  }

  Widget _buildLogOut() {
    return ButtonWidget(
      onPressed: () async {
        await cubit(context).logOut();
        Beamer.of(context).beamToReplacementNamed(AuthScreen.screenName);
      },
      label: LocaleKeys.log_out.tr(),
    );
  }
}
