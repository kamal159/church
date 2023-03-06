import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../repository/base_local_church_repository.dart';

class GetUserTableDataBaseUseCase extends BaseUseCase<bool, NoParameters> {
  final BaseLocalChurchRepository baseChurchRepository;

  GetUserTableDataBaseUseCase(this.baseChurchRepository);

  @override
  Future<Either<Failure, bool>> call(
      NoParameters parameters) async {
    return await baseChurchRepository.getUserTableDataBase();
  }
}
