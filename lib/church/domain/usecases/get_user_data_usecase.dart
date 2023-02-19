import 'package:chruch/church/data/models/verified_user_model.dart';
import 'package:chruch/church/domain/repository/base_church_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecase/base_usecase.dart';

class GetUserDataUseCase extends BaseUseCase<VerifiedUserModel, NoParameters> {
  final BaseChurchRepository baseChurchRepository;

  GetUserDataUseCase(this.baseChurchRepository);

  @override
  Future<Either<Failure, VerifiedUserModel>> call(
      NoParameters parameters) async {
    return await baseChurchRepository.getUserData();
  }
}
