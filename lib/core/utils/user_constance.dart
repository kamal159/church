import 'package:cloud_firestore/cloud_firestore.dart';

class UserConstance {
  static String uid = '';
  static String img = '';
  static String? cover;
  static String name = '';
  static String email = '';
  static String phone = '';
  static String fatherName = '';
  static String date = '';
  static String? bio;
  static bool isMale = true;
  static String? school;
  static int? level;
  static bool isEmailVerified = false;
  static bool isServant = true;
  static List<String>? subscribe;
  static bool isAdmin = true;
  static GeoPoint? position;
  static String address = '';
  static String userPath = '';

  static bool isUserDataSaved = false;
}
