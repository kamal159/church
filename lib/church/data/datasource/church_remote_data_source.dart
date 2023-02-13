import 'package:chruch/church/data/models/user_model.dart';
import 'package:chruch/core/error/exceptions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/global/components/components.dart';
import '../../domain/usecases/sign_in_usecase.dart';
import '../../domain/usecases/sign_up_usecase.dart';

abstract class BaseChurchRemoteDataSource {
  Future<String> signUp(SignUpUseCaseParameters parameters);

  Future<UserModel> signIn(SignInUseCaseParameters parameters);

// Future<List<MovieModel>> getPopularMovies();
//
// Future<List<MovieModel>> getTopRatedMovies();
//
// Future<MovieDetailModel> getMovieDetail(
//     MovieDetailUseCaseParameters parameters);
//
// Future<List<MovieRecommendationModel>> getMovieRecommendation(
//     MovieRecommendationParameters parameters);
//
// Future<NewRequestTokenModel> getNewRequestToken();
//
// Future<NewSessionModel> getNewSession(GetNewSessionUseCaseParameters parameters);
}

class ChurchRemoteDataSource extends BaseChurchRemoteDataSource {
  @override
  Future<String> signUp(SignUpUseCaseParameters parameters) async {
    final result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: parameters.email, password: parameters.password)
        .catchError((e) async {
      toastShow(
        text: e.toString().split('] ').last,
        state: ToastStates.error,
        translate: true,
      );
      throw ServerException(errorMessage: e.toString());
    });

    final UserModel model = UserModel(
      uid: result.user!.uid,
      name: parameters.name,
      email: parameters.email,
      phone: parameters.phone,
      password: parameters.password,
      fatherName: parameters.fatherName,
      date: parameters.date,
      gender: parameters.gender,
      school: parameters.school,
      isServant: parameters.isServant,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(result.user!.uid)
        .set(model.toMap())
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
      toastShow(
        text: e.toString().split('] ').last,
        state: ToastStates.error,
        translate: true,
      );
      throw ServerException(errorMessage: e.toString());
    });
    final QuerySnapshot<Map<String, dynamic>> test = await FirebaseFirestore
        .instance
        .collection('users')
        .get()
        .catchError((e) {
      toastShow(
        text: e.toString().split('] ').last,
        state: ToastStates.error,
      );
      throw ServerException(errorMessage: e.toString());
    });
    test.docs.forEach((element) {
      print(element.data()['']);
    });
    final DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(result.user!.uid)
        .get()
        .catchError((e) {
      toastShow(
        text: e.toString().split('] ').last,
        state: ToastStates.error,
      );
      throw ServerException(errorMessage: e.toString());
    });

    return UserModel.fromJson(user.data()!);
  }

// @override
// Future<List<MovieModel>> getNowPlayingMovies() async {
//   final response = await Dio().get(
//     ApiConstance.nowPlayingMoviesPath,
//     queryParameters: {
//       'api_key': ApiConstance.apiKey,
//     },
//   );
//
//   if (response.statusCode == 200) {
//     return List<MovieModel>.from(
//       (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
//     );
//   } else {
//     throw ServerException(
//       errorMessageModel: ErrorMessageModel.fromJson(response.data),
//     );
//   }
// }
//
// @override
// Future<List<MovieModel>> getPopularMovies() async {
//   final response = await Dio().get(
//     ApiConstance.nowPopularMoviesPath,
//     queryParameters: {
//       'api_key': ApiConstance.apiKey,
//     },
//   );
//
//   if (response.statusCode == 200) {
//     return List<MovieModel>.from(
//       (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
//     );
//   } else {
//     throw ServerException(
//       errorMessageModel: ErrorMessageModel.fromJson(response.data),
//     );
//   }
// }
//
// @override
// Future<List<MovieModel>> getTopRatedMovies() async {
//   final response = await Dio().get(
//     ApiConstance.nowTopRatedMoviesPath,
//     queryParameters: {
//       'api_key': ApiConstance.apiKey,
//     },
//   );
//
//   if (response.statusCode == 200) {
//     return List<MovieModel>.from(
//       (response.data['results'] as List).map((e) => MovieModel.fromJson(e)),
//     );
//   } else {
//     throw ServerException(
//       errorMessageModel: ErrorMessageModel.fromJson(response.data),
//     );
//   }
// }
//
// @override
// Future<MovieDetailModel> getMovieDetail(
//     MovieDetailUseCaseParameters parameters) async {
//   final response = await Dio().get(
//     ApiConstance.movieDetailPath(parameters.id),
//     queryParameters: {
//       'api_key': ApiConstance.apiKey,
//     },
//   );
//
//   if (response.statusCode == 200) {
//     return MovieDetailModel.fromJson(response.data);
//   } else {
//     throw ServerException(
//       errorMessageModel: ErrorMessageModel.fromJson(response.data),
//     );
//   }
// }
//
// @override
// Future<List<MovieRecommendationModel>> getMovieRecommendation(
//     MovieRecommendationParameters parameters) async {
//   final response = await Dio().get(
//     ApiConstance.movieRecommendationsPath(parameters.id),
//     queryParameters: {
//       'api_key': ApiConstance.apiKey,
//     },
//   );
//
//   if (response.statusCode == 200) {
//     return List<MovieRecommendationModel>.from(
//       (response.data['results'] as List).map((e) => MovieRecommendationModel.fromJson(e)),
//     );
//   } else {
//     throw ServerException(
//       errorMessageModel: ErrorMessageModel.fromJson(response.data),
//     );
//   }
// }
//
// @override
// Future<NewRequestTokenModel> getNewRequestToken() async {
//   final response = await Dio().get(
//     ApiConstance.newRequestPath,
//     queryParameters: {
//       'api_key': ApiConstance.apiKey,
//     },
//   );
//
//   if (response.statusCode == 200) {
//     return NewRequestTokenModel.fromJson(response.data);
//   } else {
//     throw ServerException(
//       errorMessageModel: ErrorMessageModel.fromJson(response.data),
//     );
//   }
// }
//
// @override
// Future<NewSessionModel> getNewSession(GetNewSessionUseCaseParameters parameters) async {
//   final response = await Dio().post(
//     ApiConstance.newSessionPath,
//     data: {
//       'request_token' : parameters.request,
//     },
//     queryParameters: {
//       'api_key': ApiConstance.apiKey,
//     },
//   );
//   if (response.statusCode == 200) {
//     return NewSessionModel.fromJson(response.data);
//   } else {
//     throw ServerException(
//       errorMessageModel: ErrorMessageModel.fromJson(response.data),
//     );
//   }
// }
}
