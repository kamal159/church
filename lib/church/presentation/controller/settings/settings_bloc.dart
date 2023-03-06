import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/global/components/components.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/utils/enums.dart';
import '../../../../core/utils/user_constance.dart';
import '../../../domain/usecases/remote_usecase/update_user_password_usecase.dart';
import '../../../domain/usecases/remote_usecase/update_user_profile_image_usecase.dart';
import '../sign_in/sign_in_state.dart';

part 'settings_event.dart';

part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final UpdateUserPasswordUseCase updateUserPasswordUseCase;
  final UpdateUserProfileImageUseCase updateUserProfileImageUseCase;

  SettingsBloc(
    this.updateUserPasswordUseCase,
    this.updateUserProfileImageUseCase,
  ) : super(const SettingsState()) {
    on<UpdateUserPasswordEvent>(_updateUserPassword);
    on<UpdateUserProfileImageEvent>(_updateUserProfileImage);
  }

  Future<void> logout() async {
    await CacheHelper.removeData(key: 'isUserDataSaved');
    await CacheHelper.removeData(key: 'firstDB');
    UserConstance.isEmailVerified = false;
  }

  FutureOr<void> _updateUserPassword(
      UpdateUserPasswordEvent event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(
      requestState: RequestState.loading,
    ));
    final result =
        await updateUserPasswordUseCase(UpdateUserPasswordUseCaseParameters(
      currentPassword: event.currentPassword,
      password: event.password,
    ));
    result.fold((l) {
      toastShow(
          text: 'لقد حدث خطا يرجى المحاولة مرة اخرى لاحقا',
          state: ToastStates.error);
    }, (r) async {
      if (r) {
        toastShow(
            text: 'تم تعديل الباسورد بنجاح', state: ToastStates.success);

        emit(state.copyWith(
          requestState: RequestState.success,
        ));
      } else {
        emit(state.copyWith(
          requestState: RequestState.error,
        ));
        toastShow(
            text: 'كلمة المرور الحالية غير صحيحة', state: ToastStates.error);
      }
    });
  }



  changeVisiblePassword() {
    emit(state.copyWith(visible: !state.isSure));
  }





  static XFile? image;
  Future<void> imagePicker() async {
    image = null;
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery) ?? image;
    emit(state.copyWith(image: image));
  }
  Future<FutureOr<void>> _updateUserProfileImage(UpdateUserProfileImageEvent event, Emitter<SettingsState> emit) async {

    emit(state.copyWith(
      requestUserProfileImageState: RequestState.loading,
    ));
    final result = await updateUserProfileImageUseCase(UpdateUserProfileImageUseCaseParameters(img: event.img));
    result.fold((l) {
      toastShow(
          text: 'لقد حدث خطا يرجى المحاولة مرة اخرى لاحقا',
          state: ToastStates.error);
      emit(state.copyWith(
        requestUserProfileImageState: RequestState.error,
      ));
    }, (r) async {
        toastShow(
            text: 'تم تعديل صورتك بنجاح', state: ToastStates.success);
        emit(state.copyWith(
          requestUserProfileImageState: RequestState.success,
        ));
    });

  }
}
