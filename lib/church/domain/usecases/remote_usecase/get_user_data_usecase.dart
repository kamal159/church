import 'package:chruch/church/data/models/user_data_models/user_data_model.dart';
import 'package:chruch/church/domain/repository/base_remote_church_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';

class GetUserDataUseCase extends BaseUseCase<UserDataModel, NoParameters> {
  final BaseRemoteChurchRepository baseChurchRepository;

  GetUserDataUseCase(this.baseChurchRepository);

  @override
  Future<Either<Failure, UserDataModel>> call(
      NoParameters parameters) async {
    return await baseChurchRepository.getUserData();
  }
}
