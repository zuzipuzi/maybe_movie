import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maybe_movie/src/presentation/base/cubit/cubit_state.dart';
import 'package:maybe_movie/src/presentation/base/cubit/host_cubit.dart';
import 'package:maybe_movie/src/presentation/base/localization/locale_keys.g.dart';
import 'package:maybe_movie/src/presentation/features/error_wrapper_widget.dart';
import 'package:maybe_movie/src/presentation/screens/home/home_screen.dart';
import 'package:maybe_movie/src/presentation/screens/auth/auth_cubit.dart';
import 'package:maybe_movie/src/presentation/widgets/basic_scaffold.dart';
import 'package:maybe_movie/src/presentation/widgets/button_widget.dart';
import 'package:maybe_movie/src/presentation/widgets/form_field_widget.dart';
import 'package:maybe_movie/src/utils/logger.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  static const screenName = '/authScreen';

  final ImageProvider authImage = const AssetImage("assets/images/logo.jpg");

  @override
  Widget build(BuildContext context) {
    return BasicScaffold(
      withSafeArea: false,
      child: ErrorWrapper(
        child: SingleChildScrollView(
          child: _buildAuthBody(context),
        ),
      ),
    );
  }

  Widget _buildAuthBody(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;

    return Column(
      children: [
        SizedBox(height: screenSize.height * 0.15),
        _buildImage(context),
        SizedBox(height: screenSize.height * 0.03),
        _buildText(context),
        SizedBox(height: screenSize.height * 0.08),
        _buildGetStarted(context),
        SizedBox(height: screenSize.height * 0.21),
        _buildGoToLogin(context),
      ],
    );
  }

  Widget _buildImage(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(130),
        border: Border.all(color: theme.colorScheme.primary, width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(130),
        child: Image(
          image: authImage,
          fit: BoxFit.fill,
          height: screenSize.width * 0.7,
          width: screenSize.width * 0.7,
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
      child: Text(
        LocaleKeys.maybe_movie.tr(),
        style: theme.textTheme.headline4!.copyWith(
          color: theme.colorScheme.onBackground,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildGetStarted(BuildContext context) {
    return ButtonWidget(
      label: LocaleKeys.get_started.tr(),
      onPressed: () {
        _showBottomSheet(context, isRegistration: true);
      },
    );
  }

  Widget _buildGoToLogin(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.already_have_an_account.tr(),
          style: theme.textTheme.headline2!.copyWith(
            color: theme.colorScheme.onBackground,
          ),
        ),
        TextButton(
          child: Text(
            LocaleKeys.log_in.tr(),
            style: theme.textTheme.headline3!.copyWith(
              color: theme.colorScheme.onBackground,
            ),
          ),
          onPressed: () {
            _showBottomSheet(context, isRegistration: false);
          },
        ),
      ],
    );
  }

  Future<void> _showBottomSheet(BuildContext context, {
    required bool isRegistration,
  }) {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (context) =>
          HostCubit<AuthCubit>(
            child: AuthBottomSheet(isRegistration: isRegistration),
          ),
    );
  }
}

class AuthBottomSheet extends StatefulWidget {
  const AuthBottomSheet({
    Key? key,
    required this.isRegistration,
  }) : super(key: key);

  final bool isRegistration;

  static const screenName = '/authSheet';

  @override
  State<AuthBottomSheet> createState() => _AuthBottomSheetState();
}

class _AuthBottomSheetState
    extends CubitState<AuthBottomSheet, AuthState, AuthCubit> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  final ValueKey _emailTextFieldKey = const ValueKey('emailTextFieldKey');
  final ValueKey _nameTextFieldKey = const ValueKey('nameTextFieldKey');
  final ValueKey _passwordTextFieldKey = const ValueKey('passwordTextFieldKey');
  final ValueKey _confirmPasswordTextFieldKey =
  const ValueKey('confirmPasswordTextFieldKey');

  final logger = getLogger('AuthSheet');

  @override
  void initParams(BuildContext context) {
    final state = cubit(context).state;

    _emailController
      ..text = state.email
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _emailController.text.length))
      ..addListener(() {
        cubit(context).onEmailChanged(_emailController.text);
      });

    _nameController
      ..text = state.name
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _nameController.text.length))
      ..addListener(() {
        cubit(context).onNameChanged(_nameController.text);
      });

    _passwordController
      ..text = state.password
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _passwordController.text.length))
      ..addListener(() {
        cubit(context).onPasswordChanged(_passwordController.text);
      });

    _confirmPasswordController
      ..text = state.confirmedPassword
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: _confirmPasswordController.text.length))
      ..addListener(() {
        cubit(context)
            .onRepeatedPasswordChanged(_confirmPasswordController.text);
      });
  }

  @override
  void onStateChanged(BuildContext context, AuthState state) {
    if (state.allIsValid) {
      logger.i('HI!');
      Beamer.of(context).beamToReplacementNamed(HomeScreen.screenName);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? emailErrorText(AuthState state) {
    if (state.emailAlreadyUsed) {
      return LocaleKeys.email_already_used.tr();
    } else if (state.invalidEmail) {
      return LocaleKeys.incorrect_email.tr();
    } else if (state.userNotFound) {
      return LocaleKeys.incorrect_email_or_password.tr();
    } else {
      return null;
    }
  }

  String? nameErrorText(AuthState state) {
    if (state.invalidName) {
      return LocaleKeys.incorrect_username.tr();
    } else {
      return null;
    }
  }

  String? passwordErrorText(AuthState state) {
    if (state.invalidPassword) {
      return LocaleKeys.incorrect_password.tr();
    } else if (state.userNotFound) {
      return LocaleKeys.incorrect_email_or_password.tr();
    } else {
      return null;
    }
  }

  String? confirmedPasswordErrorText(AuthState state) {
    if (state.invalidPassword) {
      return LocaleKeys.incorrect_password.tr();
    } else if (state.invalidConfirmedPassword) {
      return LocaleKeys.incorrect_confirmedPassword.tr();
    } else {
      return null;
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    return ErrorWrapper(
      errorWidgetType: ErrorWidgetType.dialog,
      child: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Padding(
              padding: MediaQuery
                  .of(context)
                  .viewInsets,
              child: _buildBody(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    final screenSize = MediaQuery
        .of(context)
        .size;
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildCloseButton(context),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.04),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.isRegistration
                    ? LocaleKeys.registration.tr()
                    : LocaleKeys.welcome_back.tr(),
                style: theme.textTheme.headline4!.copyWith(
                  color: theme.colorScheme.onBackground,
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              if (widget.isRegistration)
                Text(
                  LocaleKeys.choose_the_movie.tr(),
                  style: theme.textTheme.headline2!.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              SizedBox(height: screenSize.height * 0.03),
              _buildTextFields(),
              SizedBox(height: screenSize.height * 0.05),
              _buildWithEmail(context),
              SizedBox(height: screenSize.height * 0.02),
              if (widget.isRegistration)
                Text(
                  LocaleKeys.or.tr(),
                  style: theme.textTheme.headline3!.copyWith(
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              SizedBox(height: screenSize.height * 0.02),
              _buildWithGoogle(context),
              SizedBox(height: screenSize.height * 0.04),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.close),
    );
  }

  Widget _buildWithEmail(BuildContext context) {
    return ButtonWidget(
      label: widget.isRegistration
          ? LocaleKeys.registration.tr()
          : LocaleKeys.log_in_with_email.tr(),
      onPressed: () async {
        widget.isRegistration
            ? await cubit(context).register()
            : await cubit(context).logIn();
      },
    );
  }

  Widget _buildWithGoogle(BuildContext context) {
    return ButtonWidget(
      label: widget.isRegistration
          ? LocaleKeys.registration_with_google.tr()
          : LocaleKeys.log_in_with_google.tr(),
      isSecondaryStyle: true,
      onPressed: () async => await cubit(context).logInGoogle(),
    );
  }

  Widget _buildTextFields() {
    final screenSize = MediaQuery
        .of(context)
        .size;

    return observeState(
      builder: (context, state) =>
          Column(
            children: [
              if (widget.isRegistration)
                FormFieldWidget(
                  keyboardType: TextInputType.name,
                  key: _nameTextFieldKey,
                  controller: _nameController,
                  labelText: LocaleKeys.name.tr(),
                  hintText: LocaleKeys.full_name.tr(),
                  errorText: nameErrorText(state),
                ),
              SizedBox(height: screenSize.height * 0.01),
              FormFieldWidget(
                keyboardType: TextInputType.emailAddress,
                key: _emailTextFieldKey,
                controller: _emailController,
                labelText: LocaleKeys.email.tr(),
                hintText: LocaleKeys.example_email.tr(),
                errorText: emailErrorText(state),
              ),
              SizedBox(height: screenSize.height * 0.01),
              FormFieldWidget(
                keyboardType: TextInputType.visiblePassword,
                key: _passwordTextFieldKey,
                controller: _passwordController,
                labelText: LocaleKeys.password.tr(),
                hintText: LocaleKeys.enter_min_8_characters.tr(),
                errorText: passwordErrorText(state),
                isPasswordField: true,
              ),
              SizedBox(height: screenSize.height * 0.01),
              if (widget.isRegistration)
                FormFieldWidget(
                  keyboardType: TextInputType.visiblePassword,
                  key: _confirmPasswordTextFieldKey,
                  controller: _confirmPasswordController,
                  labelText: LocaleKeys.confirm_password.tr(),
                  hintText: LocaleKeys.repeat_please.tr(),
                  isPasswordField: true,
                  errorText: confirmedPasswordErrorText(state),
                ),
            ],
          ),
    );
  }
}
