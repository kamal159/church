import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String userPath;
  final bool isEmailVerified;
  final bool isFather;
  final bool isServant;
  final bool isAdmin;

  const User({
    required this.uid,
    required this.userPath,
    required this.isFather,
    required this.isServant,
    this.isAdmin = false,
    this.isEmailVerified = false,
  });

  @override
  List<Object> get props => [
    uid,
    userPath,
    isEmailVerified,
    isFather,
    isServant,
    isAdmin,
  ];
}
