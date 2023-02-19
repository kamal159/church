import 'dart:io';

import 'package:chruch/church/data/models/user_location_model.dart';
import 'package:chruch/church/data/models/user_model.dart';
import 'package:chruch/church/data/models/verified_user_model.dart';
import 'package:chruch/core/error/exceptions.dart';
import 'package:chruch/core/utils/app_constance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/global/components/components.dart';
import '../../../core/utils/user_Contstance.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../models/unverified_user_model.dart';

abstract class BaseChurchRemoteDataSource {
  Future<String> signUp(SignUpUseCaseParameters parameters);

  Future<UserModel> signIn(SignInUseCaseParameters parameters);

  Future<VerifiedUserModel> getUserData();

  Future<List<String>> getFathers();
}

class ChurchRemoteDataSource extends BaseChurchRemoteDataSource {
  @override
  Future<String> signUp(SignUpUseCaseParameters parameters) async {
    final result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: parameters.email, password: parameters.password)
        .catchError((e) async {
      throw ServerException(errorMessage: e.toString());
    });

    final String imageName = parameters.img.split('/').last;
    final String urlFile = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${result.user!.uid}/img/$imageName')
        .putFile(File(parameters.img))
        .then((val) async {
      return await val.ref.getDownloadURL();
    }).catchError((e) {
      debugPrint(e.toString());
      throw ServerException(errorMessage: e.toString());
    });

    final VerifiedUserModel verifiedUserModel = VerifiedUserModel(
      uid: result.user!.uid,
      name: parameters.name,
      img: urlFile,
      email: parameters.email,
      phone: parameters.phone,
      password: parameters.password,
      fatherName: parameters.fatherName,
      date: parameters.date,
      isMale: parameters.isMale,
      school: parameters.school,
      level: parameters.level,
      isServant: parameters.isServant,
      position: parameters.position,
      address: parameters.address,
      userPath: parameters.userPath,
    );

    await FirebaseFirestore.instance
        .collection('verified users/${parameters.userPath}')
        .doc(result.user!.uid)
        .set(verifiedUserModel.toMap())
        .catchError((e) {
      toastShow(
        text: e.toString().split('] ').last,
        state: ToastStates.error,
        translate: true,
      );
      throw ServerException(errorMessage: e.toString());
    });

    final UserModel userModel = UserModel(
      uid: result.user!.uid,
      userPath: parameters.userPath!,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(result.user!.uid)
        .set(userModel.toMap())
        .catchError((e) {
      toastShow(
        text: e.toString().split('] ').last,
        state: ToastStates.error,
        translate: true,
      );
      throw ServerException(errorMessage: e.toString());
    });

    final UserPositionModel userPositionModel = UserPositionModel(
      img: parameters.img,
      name: parameters.name,
      position: parameters.position,
      uid: result.user!.uid,
    );
    await FirebaseFirestore.instance
        .collection("location of users")
        .doc(result.user!.uid)
        .set(userPositionModel.toMap())
        .catchError((e) {
      toastShow(
        text: e.toString().split('] ').last,
        state: ToastStates.error,
        translate: true,
      );
      throw ServerException(errorMessage: e.toString());
    });
    final UnVerifiedUserModel unVerifiedUserModel = UnVerifiedUserModel(
      name: parameters.name,
      uid: result.user!.uid,
      img: parameters.img,
      email: parameters.email,
      phone: parameters.phone,
    );
    await FirebaseFirestore.instance
        .collection('unverified users/${parameters.userPath}')
        .doc(result.user!.uid)
        .set(unVerifiedUserModel.toMap())
        .catchError((e) {
      toastShow(
        text: e.toString().split('] ').last,
        state: ToastStates.error,
        translate: true,
      );
      throw ServerException(errorMessage: e.toString());
    });

    return result.user!.uid;
  }

  @override
  Future<UserModel> signIn(SignInUseCaseParameters parameters) async {
    final result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: parameters.email, password: parameters.password)
        .catchError((e) {
      throw ServerException(errorMessage: e.toString());
    });
    final DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(result.user!.uid)
        .get()
        .catchError((e) {
      throw ServerException(errorMessage: e.toString());
    });
    return UserModel.fromJson(user.data()!);
  }

  @override
  Future<VerifiedUserModel> getUserData() async {
    final DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(UserConstance.uid)
        .get()
        .catchError((e) {
      throw ServerException(errorMessage: e.toString());
    });

    UserModel userModel = UserModel.fromJson(userData.data()!);
    final DocumentSnapshot<Map<String, dynamic>> verifiedUser = await FirebaseFirestore
        .instance
        .collection('verified users/${userModel.userPath}')
        .doc(UserConstance.uid)
        .get()
        .catchError((e) {
      throw ServerException(errorMessage: e.toString());
    });
    return VerifiedUserModel.fromJson(verifiedUser.data()!);
  }

  @override
  Future<List<String>> getFathers() async {
    final fathers = await FirebaseFirestore.instance
        .collection('father name')
        .get()
        .catchError((e) {
      throw ServerException(errorMessage: e.toString());
    });
    List<String> list = [];
    for (var element in fathers.docs) {
      list.add(element.id);
    }

    return list;
  }
}
