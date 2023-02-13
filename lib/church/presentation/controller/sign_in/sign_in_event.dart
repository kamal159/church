
import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class SignInUserEvent extends SignInEvent {
  final String email;
  final String password;

  const SignInUserEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
    email,
    password,
  ];
}

