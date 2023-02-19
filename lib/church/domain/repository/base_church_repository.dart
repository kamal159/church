import 'package:chruch/church/data/models/verified_user_model.dart';
import 'package:chruch/church/domain/usecases/sign_in_usecase.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../data/models/login_model.dart';
import '../../data/models/user_model.dart';
import '../usecases/sign_up_usecase.dart';

abstract class BaseChurchRepository {
  Future<Either<Failure, String>> signUp(SignUpUseCaseParameters parameters);

  Future<Either<Failure, UserModel>> signIn(SignInUseCaseParameters parameters);

  Future<Either<Failure, VerifiedUserModel>> getUserData();

  Future<Either<Failure, List<String>>> getFathers();
}
