import 'package:chruch/church/domain/entities/user_data_entities/served_user_data_entity.dart';

import '../../../domain/entities/user_data_entities/servant_user_data_entity.dart';

class ServedUserDataModel extends ServedUserData {

  const ServedUserDataModel({
    required super.address,
    super.position,
    required super.img,
    required super.uid,
    super.cover,
    required super.name,
    required super.email,
    required super.phone,
    required super.fatherName,
    required super.date,
    super.bio,
    required super.isMale,
    super.level,
    required super.school,
  });

  factory ServedUserDataModel.fromJson(Map<String, dynamic> json) =>
      ServedUserDataModel(
        address: json['address'],
        position: json['position'],
        img: json['img'],
        uid: json['uid'],
        cover: json['cover'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        fatherName: json['fatherName'],
        date: json['date'],
        bio: json['bio'],
        isMale: json['isMale'],
        level: json['level'],
        school: json['school'],
      );

  @override
  Map<String, dynamic> toMap(){
    return {
      'address':address,
      'img':img,
      'uid':uid,
      'name':name,
      'email':email,
      'phone':phone,
      'fatherName':fatherName,
      'date':date,
      'isMale':isMale,
    };
  }

}
