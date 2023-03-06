import 'package:chruch/church/domain/usecases/remote_usecase/get_user_data_usecase.dart';
import 'package:chruch/core/usecase/base_usecase.dart';
import 'dart:async';
import 'package:chruch/church/presentation/controller/sign_in/sign_in_event.dart';
import 'package:chruch/church/presentation/controller/sign_in/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/global/components/components.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/user_constance.dart';
import '../../../domain/usecases/local_usecase/insert_user_data_usecase.dart';
import '../../../domain/usecases/remote_usecase/sign_in_usecase.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInUseCase signInUseCase;
  final GetUserDataUseCase getUserDataUseCase;
  final InsertUserDataUseCase insertUserDataUseCase;
  static String? formattedDate;
  static String? password;

  SignInBloc(
    this.signInUseCase,
    this.getUserDataUseCase,
    this.insertUserDataUseCase,
  ) : super(const SignInState()) {
    on<SignInUserEvent>(_signIn);
  }

  Future<FutureOr<void>> _signIn(
      SignInUserEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await signInUseCase(SignInUseCaseParameters(email: event.email, password: event.password,));
    result.fold(
      (l) {
        // UserConstance.isEmailVerified = false;
        toastShow(text: l.message.toString().split(']').last,state: ToastStates.error,translate: true);
        emit(state.copyWith(requestState: RequestState.error, errorMessage: l.message));
      },
      (r) {
        UserConstance.uid = r.uid;
        UserConstance.isEmailVerified = r.isEmailVerified;
        UserConstance.userPath = r.userPath;
      },
    );
    print(UserConstance.isEmailVerified);
    if (UserConstance.isEmailVerified) {
      final result = await getUserDataUseCase(const NoParameters());
      await result.fold((l) {

        toastShow(text: l.message.toString().split(']').last,state: ToastStates.error,translate: true);
        emit(state.copyWith(requestState: RequestState.error,errorMessage: l.message,));

      }, (r) async {
        final insertResult = await insertUserDataUseCase(InsertUserDataUseCaseParameters(
          subscribe: r.subscribe,
          level: r.level,
          email: r.email,
          address: r.address,
          position: r.position,
          img: r.img,
          uid: r.uid,
          cover: r.cover,
          name: r.name,
          phone: r.phone,
          fatherName: r.fatherName,
          date: r.date,
          bio: r.bio,
          isMale: r.isMale,
          school: r.school,
          isServant: r.isServant,
          userPath: r.userPath,
          isAdmin: r.isAdmin,
          isFather: r.isFather,
        ));
        insertResult.fold((l) {
          print(l.message);
          toastShow(text: l.message.toString().split(']').last,state: ToastStates.error,translate: true);
          emit(state.copyWith(requestState: RequestState.error,errorMessage: l.message,));
        }, (r) {
          toastShow(text: 'تم تسجيل الدخول بنجاح', state: ToastStates.success);
          emit(state.copyWith(requestState: RequestState.success,isEmailVerified: true,));
        });
      });
    } else {
      emit(state.copyWith(isEmailVerified: false,requestState: RequestState.success,));
    }
  }

  changeVisiblePassword() {
    emit(state.copyWith(visible: !state.visible));
  }

  failedToLoginState() {
    emit(state.copyWith(requestState: RequestState.waiting));
  }
}
