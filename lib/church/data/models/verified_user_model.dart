import 'package:chruch/church/domain/entities/verified_user.dart';

class VerifiedUserModel extends User {
  const VerifiedUserModel({
    required super.img,
    required super.uid,
    super.cover,
    required super.name,
    required super.email,
    required super.phone,
    required super.password,
    required super.fatherName,
    required super.date,
    super.bio,
    required super.isMale,
    required super.school,
    super.isEmailVerified,
    required super.isServant,
    super.subscribe,
    super.isAdmin,
    required super.position,
    required super.address,
    super.userPath,
    super.level,
  });

  factory VerifiedUserModel.fromJson(Map<String, dynamic> json) =>
      VerifiedUserModel(
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
        isMale: json['isMale'],
        school: json['school'],
        isEmailVerified: json['isEmailVerified'],
        isServant: json['isServant'],
        isAdmin: json['isAdmin'],
        subscribe: json['subscribe'] != null
            ? List<String>.from(json['subscribe']).map((e) => e).toList()
            : null,
        position: json['position'],
        address: json['address'],
        userPath: json['userPath'],
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
      'isMale': isMale,
      'school': school,
      'isEmailVerified': isEmailVerified,
      'isServant': isServant,
      'subscribe': subscribe,
      'isAdmin': isAdmin,
      'position': position,
      'address': address,
      'userPath': userPath,
    };
  }

  Map<String, dynamic> toDB() {
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
      'isMale': isMale ? 1 : 0,
      'school': school,
      'isEmailVerified': isEmailVerified ? 1 : 0,
      'isServant': isServant ? 1 : 0,
      'subscribe': subscribe != null ? subscribe!.join(',') : '',
      'isAdmin': isAdmin ? 1 : 0,
      'latitude': position.latitude,
      'longitude':position.longitude,
      'address': address,
      'userPath': userPath,
    };
  }
}
