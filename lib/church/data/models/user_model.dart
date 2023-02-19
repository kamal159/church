import 'package:chruch/church/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.uid,
    required super.userPath,
    super.isEmailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        userPath: json['userPath'],
        isEmailVerified: json['isEmailVerified'],
      );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userPath': userPath,
      'isEmailVerified': isEmailVerified,
    };
  }
}
