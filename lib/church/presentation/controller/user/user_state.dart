// part of 'user_bloc.dart';
//
// class UserState extends User {
//
//   const UserState({
//     super.position = const GeoPoint(0.0, 0.0),
//     super.img = '',
//     super.uid = '',
//     super.cover ='' ,
//     super.subscribe = const [],
//     super.name = '',
//     super.email = '',
//     super.phone = '',
//     super.password = '',
//     super.fatherName = '',
//     super.date = '',
//     super.bio = ,
//     super.isMale = ,
//     super.school = ,
//     super.isServant = ,
//     super.isAdmin = ,
//     super.isEmailVerified = ,
//   });
//
//   UserState copyWith({
//     final String? uid,
//     final String? img,
//     final String? cover,
//     final String? name,
//     final String? email,
//     final String? phone,
//     final String? password,
//     final String? fatherName,
//     final String? date,
//     final String? bio,
//     final bool? isMale,
//     final String? school,
//     final bool? isEmailVerified,
//     final bool? isServant,
//     final List<String>? subscribe,
//     final bool? isAdmin,
//     final GeoPoint? position,
//   }) => UserState(
//       uid:uid??this.uid,
//       img:img??this.img,
//       cover:cover??this.cover,
//       name:name??this.name,
//       email:email??this.email,
//       phone:phone??this.phone,
//       password:password??this.password,
//       fatherName:fatherName??this.fatherName,
//       date:date??this.date,
//       bio:bio??this.bio,
//       isMale:isMale??this.isMale,
//       school:school??this.school,
//       isEmailVerified:isEmailVerified??this.isEmailVerified,
//       isServant:isServant??this.isServant,
//       subscribe:subscribe??this.subscribe,
//       isAdmin:isAdmin??this.isAdmin,
//       position:position??this.position,
//   );
// }