
// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:chruch/church/presentation/controller/sign_in/sign_in_event.dart';
import 'package:chruch/church/presentation/controller/sign_in/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/global/components/components.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/utils/app_constance.dart';
import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/sign_in_usecase.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;
  static String? formattedDate;
  static String? password;

  SignInBloc(
      this.signInUseCase,
      ) : super(const SignInState()) {
    on<SignInUserEvent>(_signIn);
  }


  Future<FutureOr<void>> _signIn(SignInUserEvent event, Emitter<SignInState> emit) async {
    final result = await signInUseCase(SignInUseCaseParameters(
      email: event.email,
      password: event.password,
    ));
    result.fold(
          (l) {
        print('${l.message} l.message');
        toastShow(
            text: l.message.toString().split(']').last,
            state: ToastStates.error);

        emit(state.copyWith(
            requestState: RequestState.error, errorMessage: l.message));
      },
          (r) {
        AppConstance.uId = r.uid;
        CacheHelper.saveData(key: 'uId', value: r.uid!);
        emit(state.copyWith(uid: r.uid!, requestState: RequestState.success, isEmailVerified: r.isEmailVerified));
      },
    );

  }

  changeVisiblePassword() {
    emit(state.copyWith(visible: !state.visible));
  }

  failedToLoginState() {
    emit(state.copyWith(requestState: RequestState.waiting));
  }
}
