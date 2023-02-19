import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String userPath;
  final bool isEmailVerified;

  const User({
    required this.uid,
    required this.userPath,
    this.isEmailVerified = false,
  });

  @override
  List<Object?> get props => [
    uid,
    userPath,
    isEmailVerified,
  ];
}
