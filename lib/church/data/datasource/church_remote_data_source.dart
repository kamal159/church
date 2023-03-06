import 'dart:io';
import 'package:chruch/church/data/models/user_data_models/father_user_data_model.dart';
import 'package:chruch/church/data/models/user_data_models/servant_user_data_model.dart';
import 'package:chruch/church/data/models/user_data_models/served_user_data_model.dart';
import 'package:chruch/church/data/models/user_data_models/user_data_model.dart';
import 'package:chruch/church/domain/entities/user_data_entities/servant_user_data_entity.dart';
import 'package:chruch/church/domain/entities/user_data_entities/verified_user.dart';
import 'package:chruch/core/error/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../../../core/global/components/components.dart';
import '../../../core/utils/user_constance.dart';
import 'package:path/path.dart' show join;
import '../../domain/usecases/remote_usecase/sign_in_usecase.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../domain/usecases/remote_usecase/sign_up_usecase.dart';
import '../../domain/usecases/remote_usecase/update_user_password_usecase.dart';
import '../../domain/usecases/remote_usecase/update_user_profile_image_usecase.dart';
import '../models/user_data_models/unverified_user_model.dart';
import '../models/user_data_models/user_location_model.dart';
import '../models/user_data_models/user_model.dart';

abstract class BaseRemoteChurchDataSource {
  Future<String> signUp(SignUpUseCaseParameters parameters);

  Future<UserModel> signIn(SignInUseCaseParameters parameters);

  Future<UserDataModel> getUserData();

  Future<List<String>> getFathers();

  Future<bool> updateUserPassword(UpdateUserPasswordUseCaseParameters parameters);
  Future<bool> updateUserProfileImageUseCase(UpdateUserProfileImageUseCaseParameters parameters);
}

class ChurchRemoteDataSource extends BaseRemoteChurchDataSource {
  @override
  Future<String> signUp(SignUpUseCaseParameters parameters) async {
    final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: parameters.email, password: parameters.password).catchError((e) async => throw ServerException(errorMessage: e.toString()));

    final String imageName = parameters.img.split('/').last;
    final String urlFile = await firebase_storage.FirebaseStorage.instance.ref().child('users/${result.user!.uid}/img/$imageName').putFile(File(parameters.img)).then((val) async => await val.ref.getDownloadURL()).catchError((e) => throw ServerException(errorMessage: e.toString()));

    final BaseUserData userDataModel;
    if (parameters.isFather) {
      userDataModel = FatherUserDataModel(
        uid: result.user!.uid,
        name: parameters.name,
        img: urlFile,
        email: parameters.email,
        phone: parameters.phone,
        fatherName: parameters.fatherName,
        date: parameters.date,
        position: parameters.position,
        address: parameters.address,
      );
    } else if (parameters.isServant) {
      userDataModel = ServantUserDataModel(
        uid: result.user!.uid,
        name: parameters.name,
        img: urlFile,
        email: parameters.email,
        phone: parameters.phone,
        fatherName: parameters.fatherName,
        date: parameters.date,
        position: parameters.position,
        address: parameters.address,
        isMale: parameters.isMale,
      );
    } else {
      userDataModel = ServedUserDataModel(
        uid: result.user!.uid,
        name: parameters.name,
        img: urlFile,
        email: parameters.email,
        phone: parameters.phone,
        fatherName: parameters.fatherName,
        date: parameters.date,
        address: parameters.address,
        isMale: parameters.isMale,
        school: parameters.school!,
      );
    }
    await FirebaseFirestore.instance.collection('verified users/${parameters.userPath}').doc(result.user!.uid).set(userDataModel.toMap()).catchError((e) => throw ServerException(errorMessage: e.toString()));

    final UserModel userModel = UserModel(
      uid: result.user!.uid,
      userPath: parameters.userPath,
      isFather: parameters.isFather,
      isServant: parameters.isServant,
    );
    await FirebaseFirestore.instance.collection('users').doc(result.user!.uid).set(userModel.toMap()).catchError((e) => throw ServerException(errorMessage: e.toString()));

    final UserPositionModel userPositionModel = UserPositionModel(
      img: parameters.img,
      name: parameters.name,
      position: parameters.position!,
      uid: result.user!.uid,
    );
    await FirebaseFirestore.instance.collection("location of users").doc(result.user!.uid).set(userPositionModel.toMap()).catchError((e) => throw ServerException(errorMessage: e.toString()));

    final UnVerifiedUserModel unVerifiedUserModel = UnVerifiedUserModel(
      name: parameters.name,
      uid: result.user!.uid,
      img: parameters.img,
      email: parameters.email,
      phone: parameters.phone,
    );

    await FirebaseFirestore.instance.collection('unverified users/${parameters.userPath}').doc(result.user!.uid).set(unVerifiedUserModel.toMap()).catchError((e) => throw ServerException(errorMessage: e.toString()));

    return result.user!.uid;
  }

  @override
  Future<UserModel> signIn(SignInUseCaseParameters parameters) async {
    final result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: parameters.email, password: parameters.password).catchError((e) => throw ServerException(errorMessage: e.toString()));

    final DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore.instance.collection('users').doc(result.user!.uid).get().catchError((e) => throw ServerException(errorMessage: e.toString()));

    return UserModel.fromJson(user.data()!);
  }

  @override
  Future<UserDataModel> getUserData() async {
    final DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance.collection('users').doc(UserConstance.uid).get().catchError((e) => throw ServerException(errorMessage: e.toString()));

    final UserModel userModel = UserModel.fromJson(userData.data()!);
    final DocumentSnapshot<Map<String, dynamic>> verifiedUser = await FirebaseFirestore.instance .collection('verified users/${userModel.userPath}').doc(UserConstance.uid).get().catchError((e) => throw ServerException(errorMessage: e.toString()));

    final UserDataModel userDataModel = UserDataModel.fromJson(verifiedUser.data()!);

    return userDataModel;
  }

  @override
  Future<List<String>> getFathers() async {
    final fathers = await FirebaseFirestore.instance.collection('father name').get().catchError((e) => throw ServerException(errorMessage: e.toString()));
    List<String> list = [];
    for (var element in fathers.docs) {
      list.add(element.id);
    }
    return list;
  }

  @override
  Future<bool> updateUserPassword(UpdateUserPasswordUseCaseParameters parameters) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: UserConstance.email, password: parameters.password).catchError((e) => throw ServerException(errorMessage: e.toString()));
    await FirebaseAuth.instance.currentUser!.updatePassword(parameters.password).catchError((e) => throw ServerException(errorMessage: e.toString()));
    return true;
  }

  @override
  Future<bool> updateUserProfileImageUseCase(UpdateUserProfileImageUseCaseParameters parameters) async {
    final String imageName = parameters.img.path.split('/').last;
    final String urlFile = await firebase_storage.FirebaseStorage.instance.ref().child('users/${UserConstance.uid}/img/$imageName').putFile(File(parameters.img.path)).then((val) async => await val.ref.getDownloadURL()).catchError((e) => throw ServerException(errorMessage: e.toString()));
    await FirebaseFirestore.instance.collection('verified users/${UserConstance.userPath}').doc(UserConstance.uid).set({'img':urlFile}).catchError((e) => throw ServerException(errorMessage: e.toString()));
    final Database db = await openDatabase(join(await getDatabasesPath(), 'church.db'),version: 1);
    await db.update('user_data', {'img':urlFile});
    await db.close();
    UserConstance.img = urlFile;
    return true;
  }
}
