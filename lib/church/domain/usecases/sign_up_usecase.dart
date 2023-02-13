import 'package:chruch/church/domain/repository/base_movies_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../entities/user.dart';

class SignUpUseCase extends BaseUseCase<String, SignUpUseCaseParameters> {
  final BaseChurchRepository baseChurchRepository;

  SignUpUseCase(this.baseChurchRepository);

  @override
  Future<Either<Failure, String>> call(
      SignUpUseCaseParameters parameters) async {
    return await baseChurchRepository.signUp(parameters);
  }
}

class SignUpUseCaseParameters extends User {
  const SignUpUseCaseParameters({
    required super.uid,
    required super.name,
    required super.email,
    required super.phone,
    required super.password,
    required super.fatherName,
    required super.date,
    required super.gender,
    required super.school,
    required super.isServant,
    super.subscribe,
    super.img,
    super.cover,
    super.bio,
  });
}
