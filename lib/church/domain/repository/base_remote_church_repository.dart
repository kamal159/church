import 'package:chruch/church/data/models/user_data_models/user_data_model.dart';
import 'package:chruch/church/domain/usecases/remote_usecase/sign_in_usecase.dart';
import 'package:chruch/church/domain/usecases/remote_usecase/update_user_profile_image_usecase.dart';
import 'package:chruch/church/domain/usecases/remote_usecase/update_user_password_usecase.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../data/models/user_data_models/user_model.dart';
import '../usecases/remote_usecase/sign_up_usecase.dart';

abstract class BaseRemoteChurchRepository {
  /// [ Remote ]
  Future<Either<Failure, String>> signUp(SignUpUseCaseParameters parameters);

  Future<Either<Failure, UserModel>> signIn(SignInUseCaseParameters parameters);

  Future<Either<Failure, UserDataModel>> getUserData();

  Future<Either<Failure, List<String>>> getFathers();

  Future<Either<Failure, bool>> updateUserPassword(UpdateUserPasswordUseCaseParameters parameters);

  Future<Either<Failure, bool>> updateUserProfileImageData(UpdateUserProfileImageUseCaseParameters parameters);

}
