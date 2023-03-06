import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpUserEvent extends SignUpEvent {
  final String? uid;
  final XFile img;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String fatherName;
  final String date;
  final bool isMale;
  final String? school;
  final int? level;
  final bool isEmailVerified;
  final bool isServant;
  final GeoPoint position;
  final String address;
  final String userPath;

  const SignUpUserEvent({
    required this.img,
    required this.address,
    required this.position,
    this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.fatherName,
    required this.date,
    required this.isMale,
    this.school,
    this.level,
    this.isEmailVerified = false,
    required this.isServant,
    required this.userPath,
  });

  @override
  List<Object?> get props => [
        uid,
        address,
        img,
        position,
        name,
        email,
        phone,
        password,
        fatherName,
        date,
        isMale,
        school,
        level,
        isEmailVerified,
        isServant,
        userPath,
      ];
}

class GetFatherEvent extends SignUpEvent {}
