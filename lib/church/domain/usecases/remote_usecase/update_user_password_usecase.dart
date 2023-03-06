import 'package:chruch/church/domain/repository/base_remote_church_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';

class UpdateUserPasswordUseCase extends BaseUseCase<bool, UpdateUserPasswordUseCaseParameters> {
  final BaseRemoteChurchRepository baseChurchRepository;

  UpdateUserPasswordUseCase(this.baseChurchRepository);

  @override
  Future<Either<Failure, bool>> call(
      UpdateUserPasswordUseCaseParameters parameters) async {
    return await baseChurchRepository.updateUserPassword(parameters);
  }
}
class UpdateUserPasswordUseCaseParameters extends Equatable {
  final String currentPassword;
  final String password;

  const UpdateUserPasswordUseCaseParameters({
    required this.currentPassword,
    required this.password,
  });

  @override
  List<Object> get props => [
    currentPassword,
    password,
  ];
}
