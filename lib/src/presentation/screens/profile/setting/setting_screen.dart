import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/src/domain/entities/user/user.dart';
import 'package:maybe_movie/src/presentation/base/cubit/cubit_state.dart';
import 'package:maybe_movie/src/presentation/base/localization/locale_keys.g.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_widget.dart';
import 'package:maybe_movie/src/presentation/screens/profile/profile_screen.dart';
import 'package:maybe_movie/src/presentation/screens/profile/setting/setting_cubit.dart';
import 'package:maybe_movie/src/presentation/widgets/app_bar_widget.dart';
import 'package:maybe_movie/src/presentation/widgets/basic_scaffold.dart';
import 'package:maybe_movie/src/presentation/widgets/button_widget.dart';
import 'package:maybe_movie/src/presentation/widgets/form_field_widget.dart';
import 'package:maybe_movie/src/presentation/widgets/get_image_from_gallery.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  static const screenName = '/setting';

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState
    extends CubitState<SettingScreen, SettingState, SettingCubit> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  final ValueKey _nameTextFieldKey = const ValueKey('nameTextFieldKey');
  final ValueKey _emailTextFieldKey = const ValueKey('nameTextFieldKey');

  @override
  void initParams(BuildContext context) {
    super.initParams(context);
    if (cubit(context).state.currentUser == mockedUser) {
      cubit(context).getUserParams();
    }
    final state = cubit(context).state;

    _nameController
      ..text = state.name
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _nameController.text.length))
      ..addListener(() {
        cubit(context).onNameChanged(_nameController.text);
      });
    _emailController
      ..text = state.email
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _emailController.text.length))
      ..addListener(() {
        cubit(context).onEmailChanged(_emailController.text);
      });
  }

  @override
  Widget buildWidget(BuildContext context) {
    return BasicScaffold(
      appBar: appBarWidget(
        context,
        label: LocaleKeys.setting.tr(),
        leading: _buildButtonBack(),
      ),
      child: ErrorWrapper(
        child: observeState(
          builder: (context, state) => _buildSettingBody(),
        ),
      ),
    );
  }

  Widget _buildSettingBody() {
    final screenSize = MediaQuery.of(context).size;
    return observeState(
      builder: (context, state) => SingleChildScrollView(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 20),
              SizedBox(
                width: screenSize.width * 0.92,
                child: FormFieldWidget(
                  controller: _nameController,
                  hintText: _nameController.text == ""
                      ? state.currentUser.name
                      : _nameController.text,
                  key: _nameTextFieldKey,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenSize.width * 0.92,
                child: FormFieldWidget(
                  controller: _emailController,
                  hintText: _emailController.text == ""
                      ? state.currentUser.email
                      : _emailController.text,
                  key: _emailTextFieldKey,
                ),
              ),
              const SizedBox(height: 30),
              ButtonWidget(
                label: LocaleKeys.change_photo.tr(),
                onPressed: () async {
                  final image = await getFromGallery();
                  if (image != null) {
                    cubit(context).onImageChanged(image);
                  }
                },
                isSecondaryStyle: true,
              ),
              SizedBox(height: screenSize.height * 0.43),
              ButtonWidget(
                  onPressed: () async {
                    await cubit(context).updateUserInfo();
                  },
                  label: LocaleKeys.save_changes.tr())
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonBack() {
    final theme = Theme.of(context);
    return IconButton(
        icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
        onPressed: () {
          Beamer.of(context).beamToReplacementNamed(ProfileScreen.screenName);
        });
  }
}
