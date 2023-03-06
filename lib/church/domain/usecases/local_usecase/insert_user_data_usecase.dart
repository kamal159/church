import 'package:chruch/church/data/models/user_data_models/user_data_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_local_church_repository.dart';

class InsertUserDataUseCase extends BaseUseCase<bool, InsertUserDataUseCaseParameters> {
  final BaseLocalChurchRepository baseChurchRepository;

  InsertUserDataUseCase(this.baseChurchRepository);

  @override
  Future<Either<Failure, bool>> call(InsertUserDataUseCaseParameters parameters) async {
    return await baseChurchRepository.insertUserDataBase(parameters);
  }
}

class InsertUserDataUseCaseParameters extends UserDataModel {
  const InsertUserDataUseCaseParameters({
    required super.address,
    required super.position,
    required super.img,
    required super.uid,
    required super.cover,
    required super.subscribe,
    required super.name,
    required super.email,
    required super.phone,
    required super.fatherName,
    required super.date,
    required super.bio,
    required super.isMale,
    required super.school,
    required super.isServant,
    required super.userPath,
    required super.isAdmin,
    required super.level,
    required super.isFather,
  });
}
