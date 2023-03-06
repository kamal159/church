import '../../../domain/entities/user_data_entities/father_user_data_entity.dart';

class FatherUserDataModel extends FatherUserData {
  const FatherUserDataModel({
    required super.address,
    required super.position,
    required super.img,
    required super.uid,
    super.cover,
    required super.name,
    required super.email,
    required super.phone,
    required super.fatherName,
    required super.date,
    super.bio,
  });

  factory FatherUserDataModel.fromJson(Map<String, dynamic> json) =>
      FatherUserDataModel(
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
      );

  @override
  Map<String, dynamic> toMap(){
    return {
      'address':address,
      'position':position,
      'img':img,
      'uid':uid,
      'name':name,
      'email':email,
      'phone':phone,
      'fatherName':fatherName,
      'date':date,
    };
  }
}
