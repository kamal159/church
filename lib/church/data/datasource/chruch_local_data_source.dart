import 'package:chruch/core/error/exceptions.dart';
import 'package:sqflite/sqflite.dart';

import '../../../core/network/local/cache_helper.dart';
import '../../../core/utils/user_constance.dart';
import '../../domain/usecases/local_usecase/insert_user_data_usecase.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' show join;

import '../models/user_data_models/user_data_model.dart';


abstract class BaseLocalChurchDataSource {
  Future<bool> dropUserTableDataBase();

  Future<bool> deleteUserTableDatabase();

  Future<bool> createUserTableDataBase();

  Future<bool> getUserTableDataBase();

  Future<bool> insertUserDataBase(InsertUserDataUseCaseParameters parameters);
}

class ChurchLocalDataSource extends BaseLocalChurchDataSource {
  @override
  Future<bool> createUserTableDataBase() async {
    final Database db = await openDatabase(join(await getDatabasesPath(), 'church.db'), version: 1);
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
            isFather INTEGER, 
            isAdmin INTEGER, 
            latitude REAL, 
            longitude REAL, 
            address TEXT, 
            userPath TEXT, 
            password TEXT)
          ''').catchError((e) {
      throw LocalDatabaseException(errorMessage: e.toString());
    });
    await db.close();
    await CacheHelper.saveData(key: 'firstDB', value: false);
    return true;
  }

  @override
  Future<bool> deleteUserTableDatabase() async {
    final databasePath = join(await getDatabasesPath(), 'church.db');
    await deleteDatabase(databasePath).catchError((e) => throw LocalDatabaseException(errorMessage: e.toString()));
    return true;
  }

  @override
  Future<bool> dropUserTableDataBase() async {
    final Database db = await openDatabase(join(await getDatabasesPath(), 'church.db'));
    await db.execute('DROP TABLE IF EXISTS user_data').catchError((e) => throw LocalDatabaseException(errorMessage: e.toString()));
    await db.close();
    CacheHelper.removeData(key: 'isUserDataSaved');
    UserConstance.isUserDataSaved = false;
    print('DONE DROP TABLE');
    return true;
  }

  @override
  Future<bool> getUserTableDataBase() async {
    try{
      final Database db = await openDatabase(join(await getDatabasesPath(), 'church.db'), version: 1);
      final List<Map<String, Object?>> data = await db.query('user_data');
      await db.close();
      final UserDataModel userDataModel = UserDataModel.fromDB(data[0]);
      UserConstance.uid = userDataModel.uid!;
      UserConstance.img = userDataModel.img;
      UserConstance.cover = userDataModel.cover ?? '';
      UserConstance.name = userDataModel.name;
      UserConstance.email = userDataModel.email;
      UserConstance.phone = userDataModel.phone;
      UserConstance.fatherName = userDataModel.fatherName;
      UserConstance.date = userDataModel.date;
      UserConstance.bio = userDataModel.bio ?? '';
      UserConstance.isMale = userDataModel.isMale;
      UserConstance.school = userDataModel.school ?? '';
      UserConstance.level = userDataModel.level ?? 0;
      UserConstance.isServant = userDataModel.isServant;
      UserConstance.subscribe = userDataModel.subscribe;
      UserConstance.isAdmin = userDataModel.isAdmin;
      UserConstance.address = userDataModel.address;
      return true;
    }catch (e){
      throw LocalDatabaseException(errorMessage: e.toString());
    }
  }

  @override
  Future<bool> insertUserDataBase(InsertUserDataUseCaseParameters parameters) async {
    if (UserConstance.isUserDataSaved){
      await dropUserTableDataBase();
    }
    try {
      final bool createDB = CacheHelper.getData(key: 'firstDB') ?? true;
      if (createDB) {
        await createUserTableDataBase();
        print('done create table db');
      }
      print('now in the insert function');
      final Database db = await openDatabase(join(await getDatabasesPath(), 'church.db'),version: 1);
      await db.insert('user_data', parameters.toDB());
      await db.close();
      await CacheHelper.saveData(key: 'isUserDataSaved', value: true);
      UserConstance.isUserDataSaved = true;
      print('done inserted user data');
      await getUserTableDataBase();
      return true;
    } catch (e) {
      throw LocalDatabaseException(errorMessage: e.toString());
    }
  }
}
