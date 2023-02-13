
import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums.dart';

class SignInState extends Equatable {
  final RequestState requestState;
  final String errorMessage;
  final bool visible;
  final bool isEmailVerified;

  const SignInState({
    this.requestState = RequestState.waiting,
    this.errorMessage = '',
    this.visible = false,
    this.isEmailVerified = false,
  });
  SignInState copyWith({
    String? uid,
    RequestState? requestState,
    String? errorMessage,
    bool? visible,
    bool? isEmailVerified,
  }) =>
      SignInState(
        requestState: requestState ?? this.requestState,
        errorMessage: errorMessage ?? this.errorMessage,
        visible: visible ?? this.visible,
        isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      );

  @override
  List<Object> get props => [
    requestState,
    errorMessage,
    visible,
    isEmailVerified,
  ];
}
