part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final RequestState requestState;
  final RequestState requestUserProfileImageState;
  final String errorMessage;
  final bool isSure;
  final bool visible;
  final XFile? image;
  final CroppedFile? croppedFile;

  final String currentPassword;
  final String password;

  const SettingsState({
    this.requestState = RequestState.waiting,
    this.requestUserProfileImageState = RequestState.waiting,
    this.errorMessage = '',
    this.image,
    this.croppedFile,
    this.isSure = false,
    this.visible = false,
    this.currentPassword = '',
    this.password = '',
  });
  SettingsState copyWith({
    String? uid,
    RequestState? requestState,
    RequestState? requestUserProfileImageState,
    XFile? image,
    CroppedFile? croppedFile,
    String? errorMessage,
    bool? isSure,
    bool? visible,

    String? currentPassword,
    String? password,
  }) =>
      SettingsState(
        requestState: requestState ?? this.requestState,
        requestUserProfileImageState: requestUserProfileImageState ?? this.requestUserProfileImageState,
        errorMessage: errorMessage ?? this.errorMessage,
        isSure: isSure ?? this.isSure,
        visible: visible ?? this.visible,
        password: password ?? this.password,
        currentPassword: currentPassword ?? this.currentPassword,
        image: image ?? this.image,
        croppedFile: croppedFile ?? this.croppedFile,
      );

  @override
  List<Object?> get props => [
    requestState,
    requestUserProfileImageState,
    errorMessage,
    isSure,
    visible,
    password,
    currentPassword,
    image,
    croppedFile,
  ];
}
