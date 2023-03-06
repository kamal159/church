part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}
class UpdateUserPasswordEvent extends SettingsEvent {
  final String currentPassword;
  final String password;

  const UpdateUserPasswordEvent({
    required this.currentPassword,
    required this.password,
  });

  @override
  List<Object> get props => [
    currentPassword,
    password,
  ];
}
class UpdateUserProfileImageEvent extends SettingsEvent {
  final XFile img;

  const UpdateUserProfileImageEvent({
    required this.img,
  });

  @override
  List<Object> get props => [
    img,
  ];
}
