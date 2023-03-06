
import 'package:chruch/church/domain/entities/user_data_entities/verified_user.dart';

class ServantUserData extends BaseUserData {
  final List<String>? subscribe;
  final bool isAdmin;

  const ServantUserData({
    required this.subscribe,
    required this.isAdmin,
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
    required super.isMale,
  });

  @override
  List<Object?> get props => [
    subscribe,
    isAdmin,
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
