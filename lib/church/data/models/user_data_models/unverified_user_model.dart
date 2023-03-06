import '../../../domain/entities/user_data_entities/unverified_user.dart';

class UnVerifiedUserModel extends UnVerifiedUser {
  const UnVerifiedUserModel({
    required super.img,
    required super.email,
    required super.name,
    required super.phone,
    required super.uid,
  });

  factory UnVerifiedUserModel.fromJson(Map<String, dynamic> json) =>
      UnVerifiedUserModel(
        img: json['img'],
        email: json['email'],
        name: json['name'],
        phone: json['phone'],
        uid: json['uid'],
      );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'img': img,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
