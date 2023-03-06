import 'package:chruch/church/domain/entities/user_data_entities/verified_user.dart';

class FatherUserData extends BaseUserData {
  const FatherUserData({
    required super.address,
    required super.position,
    required super.img,
    required super.uid,
    required super.cover,
    required super.name,
    required super.email,
    required super.phone,
    required super.fatherName,
    required super.date,
    required super.bio,
    super.isMale = true,
  });

  @override
  List<Object?> get props => [
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
