
import '../../../domain/entities/user_data_entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.uid,
    required super.userPath,
    required super.isServant,
    required super.isFather,
    super.isEmailVerified,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        userPath: json['userPath'],
        isEmailVerified: json['isEmailVerified'],
        isServant: json['isServant'],
        isFather: json['isFather'],
      );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userPath': userPath,
      'isEmailVerified': isEmailVerified,
      'isFather': isFather,
      'isServant': isServant,
    };
  }
}
