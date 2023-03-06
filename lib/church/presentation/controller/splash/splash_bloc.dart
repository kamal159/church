import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chruch/core/usecase/base_usecase.dart';
import 'package:chruch/core/utils/user_constance.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/local_usecase/get_user_table_db_usecase.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetUserTableDataBaseUseCase getUserTableDataBaseUseCase;

  SplashBloc(
      this.getUserTableDataBaseUseCase,
      ) : super(const SplashState()) {
    on<GetUserTableDataBaseEvent>(_getUserTableDataBase);
  }



  Future<FutureOr<void>> _getUserTableDataBase(GetUserTableDataBaseEvent event, Emitter<SplashState> emit) async {
    if (UserConstance.isUserDataSaved){
      final result = await getUserTableDataBaseUseCase(const NoParameters());
      result.fold((l) {
        print(l.message);
        emit(state.copyWith(
          requestState: RequestState.error,
          errorMessage: l.message,
        ));
      }, (r) {
        emit(state.copyWith(
          requestState: RequestState.success,
        ));
      });
    }
    else {
      emit(state.copyWith(
        requestState: RequestState.success,
      ));
    }
  }
}
