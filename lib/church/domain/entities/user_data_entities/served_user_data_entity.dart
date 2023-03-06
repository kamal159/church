import 'package:chruch/church/domain/entities/user_data_entities/verified_user.dart';

class ServedUserData extends BaseUserData {
  final String? school;
  final int? level;

  const ServedUserData({
    this.level,
    this.school,
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
  });


  @override
  List<Object?> get props => [
    school,
    level,
    address,
    position,
    img,
    uid,
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
