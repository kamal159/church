import 'package:equatable/equatable.dart';

class UnVerifiedUser extends Equatable {
  final String img;
  final String email;
  final String name;
  final String phone;
  final String uid;

  const UnVerifiedUser({
    required this.img,
    required this.email,
    required this.name,
    required this.phone,
    required this.uid,
  });

  @override
  List<Object> get props => throw [
    img,
    email,
    name,
    phone,
    uid,
  ];
}
