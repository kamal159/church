import 'package:equatable/equatable.dart';

class User extends Equatable {
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
  final List<String>? subscribe;
  final bool isAdmin;

  const User({
    this.isAdmin = false,
    required this.img,
    required this.uid,
    required this.cover,
    required this.subscribe,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.fatherName,
    required this.date,
    required this.bio,
    required this.gender,
    required this.school,
    this.isEmailVerified = false,
    required this.isServant,
  });

  @override
  List<Object?> get props => [
    isAdmin,
    uid,
    img,
    cover,
    subscribe,
    name,
    email,
    phone,
    password,
    fatherName,
    date,
    bio,
    gender,
    school,
    isEmailVerified,
    isServant,
  ];
}