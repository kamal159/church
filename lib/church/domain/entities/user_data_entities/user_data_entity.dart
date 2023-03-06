import 'package:chruch/church/domain/entities/user_data_entities/verified_user.dart';

class UserData extends BaseUserData {
  final String? school;
  final int? level;
  final List<String>? subscribe;
  final String userPath;
  final bool isFather;
  final bool isServant;
  final bool isAdmin;

  const UserData({
    this.subscribe,
    this.school,
    this.level,
    required this.userPath,
    required this.isFather,
    required this.isServant,
    required this.isAdmin,
    super.uid,
    required super.name,
    required super.email,
    required super.phone,
    required super.fatherName,
    required super.date,
    required super.isMale,
    required super.img,
    super.cover,
    super.bio,
    required super.position,
    required super.address,
  });

  @override
  List<Object?> get props => [
    school,
    level,
    subscribe,
    address,
    position,
    uid,
    img,
    cover,
    name,
    email,
    phone,
    fatherName,
    date,
    bio,
    isMale,
    userPath,
    isFather,
    isServant,
    isAdmin,
  ];

}
