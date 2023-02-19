import 'package:chruch/church/domain/repository/base_church_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecase/base_usecase.dart';
import '../../data/models/login_model.dart';
import '../../data/models/user_model.dart';

class SignInUseCase extends BaseUseCase<UserModel, SignInUseCaseParameters> {
  final BaseChurchRepository baseChurchRepository;

  SignInUseCase(this.baseChurchRepository);

  @override
  Future<Either<Failure, UserModel>> call(SignInUseCaseParameters parameters) async {
    return await baseChurchRepository.signIn(parameters);
  }
}

class SignInUseCaseParameters extends Equatable {
  final String email;
  final String password;

  const SignInUseCaseParameters({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
    email,
    password,
  ];
}
