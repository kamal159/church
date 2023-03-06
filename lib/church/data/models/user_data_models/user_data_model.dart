import 'package:chruch/church/domain/entities/user_data_entities/user_data_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDataModel extends UserData {
  const UserDataModel({
    required super.userPath,
    required super.isFather,
    required super.isServant,
    required super.isAdmin,
    required super.uid,
    required super.name,
    required super.email,
    required super.phone,
    required super.fatherName,
    required super.date,
    required super.isMale,
    required super.img,
    super.position,
    required super.address,
    super.cover,
    super.bio,
    super.level,
    super.school,
    super.subscribe,
  });



  factory UserDataModel.fromJson(Map<String, dynamic> json) =>
      UserDataModel(
        uid: json['uid'],
        img: json['img'],
        cover: json['cover'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        fatherName: json['fatherName'],
        date: json['date'],
        bio: json['bio'],
        isMale: json['isMale'],
        school: json['school'],
        isServant: json['isServant']??false,
        isAdmin: json['isAdmin']??false,
        subscribe: json['subscribe'] != null
            ? List<String>.from(json['subscribe']).map((e) => e).toList()
            : null,
        position: json['position'],
        address: json['address'], userPath: '',
        isFather: false,
        level: json['level'],
      );


  factory UserDataModel.fromDB(Map<String, dynamic> json) =>
      UserDataModel(
        uid: json['uid'],
        img: json['img'],
        cover: json['cover'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        fatherName: json['fatherName'],
        date: json['date'],
        bio: json['bio'],
        isMale: json['isMale'] == 1,
        school: json['school'],
        isServant: json['isServant'] == 1,
        isAdmin: json['isAdmin'] == 1,
        subscribe: json['subscribe'] != null ? List<String>.from(json['subscribe'].split(',')) : null,
        // position: GeoPoint(json['latitude'].toDouble(), json['longitude'].toDouble()),
        address: json['address'],
        userPath: json['userPath'],
        isFather: json['isFather'] == 1,
        level: json['level'],
      );

  @override
  Map<String, dynamic> toMap();

  Map<String, dynamic> toDB() {
    return {
      'uid': uid,
      'img': img,
      'cover': cover,
      'name': name,
      'email': email,
      'phone': phone,
      'fatherName': fatherName,
      'date': date,
      'bio': bio,
      'isMale': isMale ? 1 : 0,
      'school': school,
      'isServant': isServant ? 1 : 0,
      'subscribe': subscribe != null ? subscribe!.join(',') : '',
      'isAdmin': isAdmin ? 1 : 0,
      'address': address,
      'userPath': userPath,
      'isFather':isFather? 1 : 0,
    };
  }
}
