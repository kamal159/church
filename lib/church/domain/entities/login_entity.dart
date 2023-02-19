import 'package:equatable/equatable.dart';

class LoginEntity extends Equatable {
  final String uid;
  final bool isEmailVerified;

  const LoginEntity({
    required this.uid,
    required this.isEmailVerified,
  });

  @override
  List<Object> get props => [
    uid,
    isEmailVerified,
  ];
}
