import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserPosition extends Equatable {
  final String img;
  final String name;
  final String uid;
  final GeoPoint position;

  const UserPosition({
    required this.img,
    required this.name,
    required this.uid,
    required this.position,
  });

  @override
  List<Object> get props => [
        img,
        name,
        uid,
        position,
      ];
}
