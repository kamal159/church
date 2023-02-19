import 'package:chruch/church/domain/repository/base_church_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../core/error/failure.dart';
import '../../../core/usecase/base_usecase.dart';

class GetFathersUseCase extends BaseUseCase<List<String>, NoParameters> {
  final BaseChurchRepository baseChurchRepository;

  GetFathersUseCase(this.baseChurchRepository);

  @override
  Future<Either<Failure, List<String>>> call(
      NoParameters parameters) async {
    return await baseChurchRepository.getFathers();
  }
}
