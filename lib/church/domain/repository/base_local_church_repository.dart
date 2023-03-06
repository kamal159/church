import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../usecases/local_usecase/insert_user_data_usecase.dart';

abstract class BaseLocalChurchRepository {

  /// [ local ]
  Future<Either<Failure, bool>> insertUserDataBase(InsertUserDataUseCaseParameters parameters);

  Future<Either<Failure, bool>> createUserTableDataBase();

  Future<Either<Failure, bool>> deleteUserTableDatabase();

  Future<Either<Failure, bool>> dropUserTableDatabase();

  Future<Either<Failure, bool>> getUserTableDataBase();
}
