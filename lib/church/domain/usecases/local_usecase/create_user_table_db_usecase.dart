import 'package:chruch/church/domain/repository/base_remote_church_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../../data/datasource/chruch_local_data_source.dart';
import '../../repository/base_local_church_repository.dart';

class CreateUserTableDBUseCase extends BaseUseCase<bool, NoParameters> {
  final BaseLocalChurchRepository baseLocalChurchRepository;

  CreateUserTableDBUseCase(this.baseLocalChurchRepository);

  @override
  Future<Either<Failure, bool>> call(NoParameters parameters) async {
    return await baseLocalChurchRepository.createUserTableDataBase();
  }
}
