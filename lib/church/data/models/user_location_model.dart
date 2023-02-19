import '../../domain/entities/user_position.dart';

class UserPositionModel extends UserPosition {
  const UserPositionModel({
    required super.img,
    required super.name,
    required super.uid,
    required super.position,
  });

  factory UserPositionModel.fromJson(Map<String, dynamic> json) =>
      UserPositionModel(
        img: json['img'],
        name: json['name'],
        uid: json['uid'],
        position: json['position'],
      );

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'img': img,
      'name': name,
      'position': position,
    };
  }
}
