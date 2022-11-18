part of 'setting_cubit.dart';

class SettingState extends Equatable {
  const SettingState({
    this.currentUser = mockedUser,
    this.image,
    this.name = '',
    this.email = '',

  });

  final User currentUser;
  final File? image;
  final String name;
  final String email;


  SettingState copyWith({
    User? currentUser,
    File? image,
    String? name,
    String? email,
  }) {
    return SettingState(
      currentUser: currentUser ?? this.currentUser,
      image: image ?? this.image,
      name: name ?? this.name,
      email: email ?? this.email,

    );
  }

  @override
  List<Object?> get props => [
        currentUser,
        image,
        name,
        email,

      ];
}
