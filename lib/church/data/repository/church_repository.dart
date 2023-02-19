import 'package:chruch/church/data/models/verified_user_model.dart';
import 'package:chruch/church/domain/usecases/sign_in_usecase.dart';
import 'package:chruch/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/repository/base_church_repository.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../datasource/church_remote_data_source.dart';
import '../models/login_model.dart';
import '../models/user_model.dart';

class ChurchRepository extends BaseChurchRepository {
  final BaseChurchRemoteDataSource baseChurchRemoteDataSource;

  ChurchRepository(this.baseChurchRemoteDataSource);

  @override
  Future<Either<Failure, String>> signUp(
      SignUpUseCaseParameters parameters) async {
    try {
      final result = await baseChurchRemoteDataSource.signUp(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signIn(
      SignInUseCaseParameters parameters) async {
    try {
      final result = await baseChurchRemoteDataSource.signIn(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, VerifiedUserModel>> getUserData() async {
    try {
      final result = await baseChurchRemoteDataSource.getUserData();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getFathers() async {
    try {
      final result = await baseChurchRemoteDataSource.getFathers();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessage));
    }
  }
}
