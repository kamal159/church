
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpUserEvent extends SignUpEvent {
  final String? uid;
  final String? img;
  final String? cover;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String fatherName;
  final String date;
  final String? bio;
  final String gender;
  final String? school;
  final bool isEmailVerified;
  final bool isServant;

  const SignUpUserEvent({
    this.img,
    this.uid,
    this.cover,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.fatherName,
    required this.date,
    this.bio,
    required this.gender,
    this.school,
    this.isEmailVerified = false,
    required this.isServant,
  });

  @override
  List<Object> get props => [
    uid!,
    img!,
    cover!,
    name,
    email,
    phone,
    password,
    fatherName,
    date,
    bio!,
    gender,
    school!,
    isEmailVerified,
    isServant,
  ];
}

