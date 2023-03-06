import 'package:chruch/church/domain/repository/base_remote_church_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../entities/user_data_entities/user_data_entity.dart';

class SignUpUseCase extends BaseUseCase<String, SignUpUseCaseParameters> {
  final BaseRemoteChurchRepository baseChurchRepository;

  SignUpUseCase(this.baseChurchRepository);

  @override
  Future<Either<Failure, String>> call(SignUpUseCaseParameters parameters) async {
    return await baseChurchRepository.signUp(parameters);
  }
}

class SignUpUseCaseParameters extends UserData {
  final String password;
  const SignUpUseCaseParameters({
    super.school,
    super.level,
    super.subscribe,
    required super.isFather,
    required super.isAdmin,
    required super.name,
    required super.email,
    required super.phone,
    required this.password,
    required super.fatherName,
    required super.date,
    required super.isMale,
    required super.isServant,
    required super.img,
    super.cover,
    super.bio,
    required super.position,
    required super.address,
    required super.userPath,
  });

  @override
  List<Object?> get props => [
        userPath,
        isFather,
        school,
        level,
        subscribe,
        isAdmin,
        address,
        position,
        uid,
        img,
        cover,
        name,
        email,
        phone,
        fatherName,
        date,
        bio,
        isMale,
        isServant,
        userPath,
        password,
      ];
}
