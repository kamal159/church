import 'package:chruch/church/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    super.img,
    required super.uid,
    super.cover,
    required super.name,
    required super.email,
    required super.phone,
    required super.password,
    required super.fatherName,
    required super.date,
    super.bio,
    required super.gender,
    required super.school,
    super.isEmailVerified,
    required super.isServant,
    super.subscribe,
    super.isAdmin,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      UserModel(
        uid: json['uid'],
        img: json['img'],
        cover: json['cover'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        password: json['password'],
        fatherName: json['fatherName'],
        date: json['date'],
        bio: json['bio'],
        gender: json['gender'],
        school: json['school'],
        isEmailVerified: json['isEmailVerified'],
        isServant: json['isServant'],
        isAdmin: json['isAdmin'],
        subscribe: List<String>.from(json['subscribe']).map((e) => e).toList(),
      );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'img': img,
      'cover': cover,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'fatherName': fatherName,
      'date': date,
      'bio': bio,
      'gender': gender,
      'school': school,
      'isEmailVerified': isEmailVerified,
      'isServant': isServant,
      'subscribe': subscribe,
      'isAdmin': isAdmin,
    };
  }
}
