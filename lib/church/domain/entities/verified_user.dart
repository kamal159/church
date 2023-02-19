import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class VerifiedUser extends Equatable {
  final String? uid;
  final String img;
  final String? cover;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String fatherName;
  final String date;
  final String? bio;
  final bool isMale;
  final String? school;
  final String? level;
  final bool isEmailVerified;
  final bool isServant;
  final List<String>? subscribe;
  final bool isAdmin;
  final GeoPoint position;
  final String address;
  final String? userPath;

  const VerifiedUser({
    required this.address,
    this.isAdmin = false,
    required this.position,
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
    required this.isMale,
    required this.school,
    this.isEmailVerified = false,
    required this.isServant,
    required this.userPath,
    this.level,
  });

  @override
  List<Object?> get props => [
    isAdmin,
    address,
    position,
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
    isMale,
    school,
    level,
    isEmailVerified,
    isServant,
    userPath,
  ];
}