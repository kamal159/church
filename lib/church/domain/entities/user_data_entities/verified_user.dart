import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BaseUserData extends Equatable {
  final String? uid;
  final String img;
  final String? cover;
  final String name;
  final String email;
  final String phone;
  final String fatherName;
  final String date;
  final String? bio;
  final bool isMale;
  final GeoPoint? position;
  final String address;

  const BaseUserData({
    required this.address,
    this.position,
    required this.img,
    this.uid,
    required this.cover,
    required this.name,
    required this.email,
    required this.phone,
    required this.fatherName,
    required this.date,
    required this.bio,
    required this.isMale,
  });
  Map<String, dynamic> toMap() {
    return {};
  }
  @override
  List<Object?> get props => [
    address,
    position,
    uid,
    img,
    cover,
    name,
    email,
    phone,
    fatherName,
    date,
    bio,
    isMale,
  ];


}