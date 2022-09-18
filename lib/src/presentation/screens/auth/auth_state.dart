part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.email = '',
    this.name = '',
    this.password = '',
    this.confirmedPassword = '',
    this.allFieldsFilled = false,
    this.invalidEmail = false,
    this.invalidName = false,
    this.invalidPassword = false,
    this.invalidConfirmedPassword = false,
    this.failed = false,
    this.allIsValid = false,
    this.emailAlreadyUsed = false,
    this.userNotFound = false,
  });

  final String email;
  final String name;
  final String password;
  final String confirmedPassword;
  final bool allFieldsFilled;
  final bool invalidEmail;
  final bool invalidName;
  final bool invalidPassword;
  final bool invalidConfirmedPassword;
  final bool failed;
  final bool allIsValid;
  final bool emailAlreadyUsed;
  final bool userNotFound;

  AuthState copyWith({
    String? email,
    String? name,
    String? password,
    String? confirmedPassword,
    bool? allFieldsFilled,
    bool? invalidEmail,
    bool? invalidName,
    bool? invalidPassword,
    bool? invalidConfirmedPassword,
    bool? failed,
    bool? allIsValid,
    bool? emailAlreadyUsed,
    bool? userNotFound,
  }) {
    return AuthState(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      allFieldsFilled: allFieldsFilled ?? this.allFieldsFilled,
      invalidEmail: invalidEmail ?? this.invalidEmail,
      invalidName: invalidName ?? this.invalidName,
      invalidPassword: invalidPassword ?? this.invalidPassword,
      invalidConfirmedPassword:
          invalidConfirmedPassword ?? this.invalidConfirmedPassword,
      failed: failed ?? this.failed,
      allIsValid: allIsValid ?? this.allIsValid,
      emailAlreadyUsed: emailAlreadyUsed ?? this.emailAlreadyUsed,
      userNotFound: userNotFound ?? this.userNotFound,
    );
  }

  @override
  List<Object> get props => [
        email,
        name,
        password,
        confirmedPassword,
        allFieldsFilled,
        invalidEmail,
        invalidName,
        invalidPassword,
        invalidConfirmedPassword,
        failed,
        allIsValid,
        emailAlreadyUsed,
        userNotFound,
      ];
}
