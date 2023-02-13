import 'package:chruch/church/data/models/user_model.dart';
import 'package:chruch/church/domain/usecases/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';
import '../usecases/sign_up_usecase.dart';

abstract class BaseChurchRepository {

  Future<Either<Failure, String>> signUp(SignUpUseCaseParameters parameters);

  Future<Either<Failure, UserModel>> signIn(SignInUseCaseParameters parameters);
  //
  // Future<Either<Failure, List<Movie>>> getPopularMovies();
  //
  // Future<Either<Failure, List<Movie>>> getTopRatedMovies();
  //
  // Future<Either<Failure, MovieDetail>> getMovieDetail(
  //     MovieDetailUseCaseParameters parameters);
  //
  // Future<Either<Failure, List<MovieRecommendation>>> getMovieRecommendation(
  //     MovieRecommendationParameters parameters);
  //
  // Future<Either<Failure, NewRequestToken>> getNewRequestToken();
  //
  // Future<Either<Failure, NewSession>> getNewSession(GetNewSessionUseCaseParameters parameters);

}
