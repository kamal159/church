import 'package:chruch/church/domain/repository/base_remote_church_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../../data/models/login_model.dart';
import '../../../data/models/user_data_models/user_model.dart';

class UpdateUserProfileImageUseCase extends BaseUseCase<bool, UpdateUserProfileImageUseCaseParameters> {
  final BaseRemoteChurchRepository baseChurchRepository;

  UpdateUserProfileImageUseCase(this.baseChurchRepository);

  @override
  Future<Either<Failure, bool>> call(UpdateUserProfileImageUseCaseParameters parameters) async {
    return await baseChurchRepository.updateUserProfileImageData(parameters);
  }
}

class UpdateUserProfileImageUseCaseParameters extends Equatable {
  final XFile img;

  const UpdateUserProfileImageUseCaseParameters({
    required this.img,
  });

  @override
  List<Object> get props => [
    img,
  ];
}
