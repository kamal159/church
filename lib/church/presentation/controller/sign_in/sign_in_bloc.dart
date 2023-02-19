// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'dart:developer';

import 'package:chruch/church/domain/entities/verified_user.dart';
import 'package:chruch/church/domain/usecases/get_user_data_usecase.dart';
import 'package:chruch/core/usecase/base_usecase.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

import 'package:chruch/church/presentation/controller/sign_in/sign_in_event.dart';
import 'package:chruch/church/presentation/controller/sign_in/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

import '../../../../core/global/components/components.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/utils/app_constance.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/user_Contstance.dart';
import '../../../data/models/verified_user_model.dart';
import '../../../domain/usecases/sign_in_usecase.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;
  final GetUserDataUseCase getUserDataUseCase;
  static String? formattedDate;
  static String? password;

  SignInBloc(
    this.signInUseCase,
    this.getUserDataUseCase,
  ) : super(const SignInState()) {
    on<SignInUserEvent>(_signIn);
  }

  Future<FutureOr<void>> _signIn(
      SignInUserEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await signInUseCase(SignInUseCaseParameters(
      email: event.email,
      password: event.password,
    ));
    result.fold(
      (l) {
        toastShow(
            text: l.message.toString().split(']').last,
            state: ToastStates.error,
            translate: true);

        emit(state.copyWith(
            requestState: RequestState.error, errorMessage: l.message));
      },
      (r) {
        UserConstance.isEmailVerified = r.isEmailVerified;
        UserConstance.userPath = r.userPath;


      },
    );
    if (UserConstance.isEmailVerified??false) {
      final result = await getUserDataUseCase(const NoParameters());
      result.fold((l) {
        emit(state.copyWith(
          requestState: RequestState.error,
          errorMessage: l.message,
        ));
      }, (r) {
        createUserDataBase(r);
        toastShow(text: 'تم تسجيل الدخول بنجاح', state: ToastStates.success);
        emit(state.copyWith(
          requestState: RequestState.success,
          isEmailVerified: r.isEmailVerified,
        ));
      });
    }else{
      emit(state.copyWith(
        isEmailVerified: false,
        requestState: RequestState.success,
      ));
    }
  }

  changeVisiblePassword() {
    emit(state.copyWith(visible: !state.visible));
  }

  failedToLoginState() {
    emit(state.copyWith(requestState: RequestState.waiting));
  }


  createUserDataBase(VerifiedUserModel verifiedUserModel) async {
    await deleteDB();
    print('start');
    await openDatabase(
      join(await getDatabasesPath(), 'church.db'),
      version: 1,
      onCreate: (db, version) async {
        print('ready');
        await db.execute('''
          CREATE TABLE user_data (
            uid TEXT PRIMARY KEY,
            name TEXT, 
            img TEXT, 
            cover TEXT, 
            email TEXT, 
            phone TEXT, 
            fatherName TEXT, 
            date TEXT, 
            bio TEXT, 
            isMale INTEGER, 
            school TEXT, 
            isEmailVerified INTEGER, 
            isServant INTEGER, 
            subscribe TEXT, 
            isAdmin INTEGER, 
            latitude REAL, 
            longitude REAL, 
            address TEXT, 
            userPath TEXT, 
            password TEXT)
          ''').catchError((e) {
          print(e.toString());
        });
        await db.insert('user_data', verifiedUserModel.toDB());
        await CacheHelper.saveData(key: 'isUserDataSaved', value: true);
      },
      onOpen: (db) async {
        await getUserDB();
      },
    );
  }
}

// kamal11@gm.com