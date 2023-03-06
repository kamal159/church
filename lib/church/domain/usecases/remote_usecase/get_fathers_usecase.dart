import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_remote_church_repository.dart';

class GetFathersUseCase extends BaseUseCase<List<String>, NoParameters> {
  final BaseRemoteChurchRepository baseChurchRepository;

  GetFathersUseCase(this.baseChurchRepository);

  @override
  Future<Either<Failure, List<String>>> call(
      NoParameters parameters) async {
    return await baseChurchRepository.getFathers();
  }
}
