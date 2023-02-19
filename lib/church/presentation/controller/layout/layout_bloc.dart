import 'dart:async';
import 'dart:developer';

import 'package:chruch/core/network/local/cache_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/utils/enums.dart';
import '../../../data/models/verified_user_model.dart';
import '../../../domain/usecases/get_user_data_usecase.dart';
import 'layout_event.dart';
import 'layout_state.dart';

class LayoutBloc extends Bloc<LayoutEvent, LayoutState> {
  final GetUserDataUseCase getUserDataUseCase;

  LayoutBloc(this.getUserDataUseCase) : super(const LayoutState()) {
    on<GetUserDataEvent>(_getUserData);
  }

  FutureOr<void> _getUserData(
      GetUserDataEvent event, Emitter<LayoutState> emit) async {
    emit(state.copyWith(
      userRequestState: RequestState.loading,
    ));
    final result = await getUserDataUseCase(const NoParameters());
    result.fold((l) {
      emit(state.copyWith(
        userRequestState: RequestState.error,
        errorMessage: l.message,
      ));
    }, (r) {

      // print('heyyyyy uu');
      // bool? isUserDataSaved = CacheHelper.getData(key: 'isUserDataSaved');
      // print(isUserDataSaved);
      // if (isUserDataSaved == null || !isUserDataSaved) {
        setUserDataBase(r);
      // }
      // fetchData();
      emit(state.copyWith(
        userRequestState: RequestState.success,
        userModel: r,
      ));
    });
  }

  deleteDB() async {
    final Database db = await openDatabase('church.db');
    final databasePath = join(await getDatabasesPath(), 'church.db');
    await db.execute('DROP TABLE IF EXISTS user_data');
    await db.close();
    await deleteDatabase(databasePath);
    print('DONE DELETE');
  }
  setUserDataBase(VerifiedUserModel verifiedUserModel) async {
    await deleteDB();
    print('start');
    final db = await openDatabase(
      join(await getDatabasesPath(), 'church.db'),
      version: 1,
      onCreate: (db, version) async {
        print('ready');
        await db.execute('''
          CREATE TABLE user_data (
            uid INTEGER PRIMARY KEY,
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
          ''').catchError((e){
            print(e.toString());
        });
        print('OK');
        await db.insert('user_data', verifiedUserModel.toDB());
        await CacheHelper.saveData(key: 'isUserDataSaved', value: true);
      },
      onOpen: (db) async {
        // print(await db.query('user_data'));
      },
    );
  }

  Future<void> fetchData() async {
    final Database db = await openDatabase(
      'church.db',
      onOpen: (db) {
        print(db.path);
      },
      version: 1,
    );
    log(db.query('user_data').toString());
  }
}
