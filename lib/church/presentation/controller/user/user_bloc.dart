// import 'dart:async';
//
// import 'package:chruch/church/domain/entities/verified_user.dart';
// import 'package:chruch/core/usecase/base_usecase.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../../core/global/components/components.dart';
// import '../../../../core/utils/enums.dart';
// import '../../../domain/usecases/get_user_data_usecase.dart';
//
// part 'user_event.dart';
// part 'user_state.dart';
//
// class UserBloc extends Bloc<UserEvent, UserState> {
//   final GetUserDataUseCase getUserDataUseCase;
//   UserBloc(this.getUserDataUseCase) : super(UserState()) {
//     on<GetUserDataEvent>(_getUserData);
//   }
//
//
//   FutureOr<void> _getUserData(
//       GetUserDataEvent event, Emitter<UserState> emit) async {
//     final result = await getUserDataUseCase(const NoParameters());
//     result.fold(
//       (l) {
//         Timestamp.fromDate(DateTime(DateTime.april));
//         toastShow(
//             text: l.message.toString().split(']').last,
//             state: ToastStates.error,
//             translate: true);
//         emit(state.copyWith(
//             requestState: RequestState.error, errorMessage: l.message));
//       },
//       (r) {
//         emit(state.copyWith(
//             uid: r.uid,
//             requestState: RequestState.success,
//             isEmailVerified: r.isEmailVerified));
//       },
//     );
//   }
// }
