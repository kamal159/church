import 'package:chruch/church/domain/usecases/remote_usecase/sign_in_usecase.dart';
import 'package:chruch/church/domain/usecases/remote_usecase/update_user_profile_image_usecase.dart';
import 'package:chruch/church/domain/usecases/remote_usecase/update_user_password_usecase.dart';
import 'package:chruch/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/exceptions.dart';
import '../../domain/repository/base_remote_church_repository.dart';
import '../../domain/usecases/remote_usecase/sign_up_usecase.dart';
import '../datasource/church_remote_data_source.dart';
import '../models/user_data_models/user_data_model.dart';
import '../models/user_data_models/user_model.dart';

class RemoteChurchRepository extends BaseRemoteChurchRepository {
  final BaseRemoteChurchDataSource baseChurchRemoteDataSource;

  RemoteChurchRepository(this.baseChurchRemoteDataSource);

  /// [ Local ]
  @override
  Future<Either<Failure, String>> signUp(SignUpUseCaseParameters parameters) async {
    try {
      final result = await baseChurchRemoteDataSource.signUp(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signIn(SignInUseCaseParameters parameters) async {
    try {
      final result = await baseChurchRemoteDataSource.signIn(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserDataModel>> getUserData() async {
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

  @override
  Future<Either<Failure, bool>> updateUserPassword(UpdateUserPasswordUseCaseParameters parameters) async {
    try {
      final result =
          await baseChurchRemoteDataSource.updateUserPassword(parameters);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserProfileImageData(UpdateUserProfileImageUseCaseParameters parameters) async {
   try{
     final result = await baseChurchRemoteDataSource.updateUserProfileImageUseCase(parameters);
     return Right(result);
   } on ServerException catch (failure) {
     return Left(ServerFailure(failure.errorMessage));
   }
  }
}

