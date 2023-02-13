import 'package:chruch/church/data/models/user_model.dart';
import 'package:chruch/church/domain/usecases/sign_in_usecase.dart';
import 'package:chruch/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../domain/repository/base_movies_repository.dart';
import '../../domain/usecases/sign_up_usecase.dart';
import '../datasource/church_remote_data_source.dart';

class ChurchRepository extends BaseChurchRepository {
  final BaseChurchRemoteDataSource baseChurchRemoteDataSource;

  ChurchRepository(this.baseChurchRemoteDataSource);

  @override
  Future<Either<Failure, String>> signUp(
      SignUpUseCaseParameters parameters) async {
    final result = await baseChurchRemoteDataSource.signUp(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessage));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signIn(SignInUseCaseParameters parameters) async {
    final result = await baseChurchRemoteDataSource.signIn(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessage));
    }
  }
//
// @override
// Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
//   final result = await baseMovieRemoteDataSource.getNowPlayingMovies();
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
//   }
// }
//
// @override
// Future<Either<Failure, List<Movie>>> getPopularMovies() async {
//   final result = await baseMovieRemoteDataSource.getPopularMovies();
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
//   }
// }
//
// @override
// Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
//   final result = await baseMovieRemoteDataSource.getTopRatedMovies();
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
//   }
// }
//
// @override
// Future<Either<Failure, MovieDetail>> getMovieDetail(
//     MovieDetailUseCaseParameters parameters) async {
//   final result = await baseMovieRemoteDataSource.getMovieDetail(parameters);
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
//   }
// }
//
// @override
// Future<Either<Failure, List<MovieRecommendation>>> getMovieRecommendation(MovieRecommendationParameters parameters) async {
//   final result = await baseMovieRemoteDataSource.getMovieRecommendation(parameters);
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
//   }
//
// }
//
// @override
// Future<Either<Failure, NewRequestToken>> getNewRequestToken() async {
//   final result = await baseMovieRemoteDataSource.getNewRequestToken();
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
//   }
// }
//
// @override
// Future<Either<Failure, NewSession>> getNewSession(GetNewSessionUseCaseParameters parameters) async {
//   final result = await baseMovieRemoteDataSource.getNewSession(parameters);
//   try {
//     return Right(result);
//   } on ServerException catch (failure) {
//     return Left(ServerFailure(failure.errorMessageModel.statusMessage));
//   }
// }
}
