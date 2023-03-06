import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failure.dart';
import '../../domain/repository/base_local_church_repository.dart';
import '../../domain/repository/base_remote_church_repository.dart';
import '../../domain/usecases/local_usecase/insert_user_data_usecase.dart';
import '../datasource/chruch_local_data_source.dart';

class LocalChurchRepository extends BaseLocalChurchRepository {
  final BaseLocalChurchDataSource baseChurchLocalDataSource;

  LocalChurchRepository(this.baseChurchLocalDataSource);

  /// [ Remote ]
  @override
  Future<Either<Failure, bool>> insertUserDataBase(InsertUserDataUseCaseParameters parameters) async {
    try {
      final result =
      await baseChurchLocalDataSource.insertUserDataBase(parameters);
      return Right(result);
    } on LocalDatabaseException catch (failure) {
      return Left(DatabaseFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> createUserTableDataBase() async {
    try {
      final result = await baseChurchLocalDataSource.createUserTableDataBase();
      return Right(result);
    } on LocalDatabaseException catch (failure) {
      return Left(DatabaseFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUserTableDatabase() async {
    try {
      final result = await baseChurchLocalDataSource.createUserTableDataBase();
      return Right(result);
    } on LocalDatabaseException catch (failure) {
      return Left(DatabaseFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> dropUserTableDatabase() async {
    try {
      final result = await baseChurchLocalDataSource.dropUserTableDataBase();
      return Right(result);
    } on LocalDatabaseException catch (failure) {
      return Left(DatabaseFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> getUserTableDataBase() async {
    try {
      final result = await baseChurchLocalDataSource.getUserTableDataBase();
      return Right(result);
    } on LocalDatabaseException catch (failure) {
      return Left(DatabaseFailure(failure.errorMessage));
    }
  }
}
