// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'package:chruch/church/domain/entities/school_grades.dart';
import 'package:chruch/church/presentation/controller/sign_up/sign_up_event.dart';
import 'package:chruch/church/presentation/controller/sign_up/sign_up_state.dart';
import 'package:chruch/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/global/components/components.dart';
import '../../../../core/network/local/cache_helper.dart';
import '../../../../core/utils/app_constance.dart';
import '../../../domain/usecases/sign_up_usecase.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;

  static String? formattedDate;
  static String? password;
  static Position? position;

  SignUpBloc(
    this.signUpUseCase,
  ) : super(const SignUpState()) {
    on<SignUpUserEvent>(_signUp);
  }

  int lastSelectGender = -1;
  static List<bool> genderSelections = List.generate(2, (index) => false);

  static List<String> levelGrades = [
    'الاول',
    'الثاني',
    'الثالث',
    'الرابع',
    'الخامس',
    'السادس',
    'السابع',
    'الثامن',
  ];

  // static Map<String, int> schoolGrades = {
  //   'ابتدائية': 6,
  //   'اعدادي': 3,
  //   'ثانوية': 3,
  //   'شباب': 7,
  //   'خريجين': 0,
  //   'شباب (سمعان الشيخ)': 0,
  // };

  static bool? isMale;
  static List<SchoolGrade> schoolGradeModel = [
    SchoolGrade(
      levelCount: 6,
      nameGrade: 'ابتدائية',
    ),
    SchoolGrade(
      levelCount: 3,
      nameGrade: 'اعدادي',
    ),
    SchoolGrade(
      levelCount: 3,
      nameGrade: 'ثانوية',
    ),
    SchoolGrade(
      levelCount: 7,
      nameGrade: 'شباب',
    ),
    SchoolGrade(
      levelCount: 0,
      nameGrade: 'خريجين',
    ),
    SchoolGrade(
      levelCount: 0,
      nameGrade: 'شباب (سمعان الشيخ)',
    ),
  ];

  static List<bool> schoolSelections =
      List.generate(levelGrades.length, (index) => false);

  bool suffixIconVisible = false;

  Future<FutureOr<void>> _signUp(
      SignUpUserEvent event, Emitter<SignUpState> emit) async {
    state.copyWith(requestState: RequestState.loading);
    final result = await signUpUseCase(SignUpUseCaseParameters(
      uid: event.uid,
      name: event.name,
      date: event.date,
      fatherName: event.fatherName,
      email: event.email,
      phone: event.phone,
      password: event.password,
      school: event.school,
      gender: event.gender,
      isServant: event.isServant,
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
        emit(state.copyWith(uid: r, requestState: RequestState.success));
      },
    );
  }

  static int lastSelectSchool = -1;

  selectSchool(int index) {
    if (lastSelectSchool == -1) {
      lastSelectSchool = index;
      schoolSelections[index] = true;
    } else if (index != lastSelectSchool) {
      schoolSelections[lastSelectSchool] = false;
      lastSelectSchool = index;
      schoolSelections[index] = true;
    }
    emit(state.copyWith(
      lastSelectSchool: lastSelectSchool,
    ));
  }

  selectOtherSchool(int index) {
    if (schoolGradeModel[lastExpandedGrade].isExpanded) {
      schoolGradeModel[lastExpandedGrade].isExpanded = false;
    }
    if (lastSelectSchool != -1) {
      schoolSelections[lastSelectSchool] = false;
      lastSelectSchool = -1;
    }
    schoolGradeModel[index].isExpanded = true;
    lastExpandedGrade = index;
    emit(state.copyWith(
      lastSelectSchool: lastSelectSchool,
      lastExpandedGrade: lastExpandedGrade,
    ));
  }

  static int lastExpandedGrade = 0;

  changeExpanded(int index, bool isExpanded) {
    schoolGradeModel[lastExpandedGrade].isExpanded = false;
    schoolGradeModel[index].isExpanded = !isExpanded;
    lastExpandedGrade = index;
    if (lastSelectSchool != -1) {
      schoolSelections[lastSelectSchool] = false;
      lastSelectSchool = -1;
    }
    emit(state.copyWith(
      isExpanded: !isExpanded,
      lastExpandedGrade: index,
      lastSelectSchool: -1,
    ));
  }

  changeVisiblePassword() {
    emit(state.copyWith(visible: !state.visible));
  }

  static bool isServant = false;

  changeIsServant(val) {
    isServant = val;
    emit(state.copyWith(isServant: val));
  }

  void changeGender(int index) {
    if (lastSelectGender == -1) {
      lastSelectGender = index;
      genderSelections[index] = true;

      if (index == 1) {
        isMale = true;
      } else {
        isMale = false;
      }
    } else if (index != lastSelectGender) {
      genderSelections[lastSelectGender] = false;
      lastSelectGender = index;
      genderSelections[index] = true;

      if (index == 1) {
        isMale = true;
      } else {
        isMale = false;
      }
    }
    emit(state.copyWith(
      lastSelectGender: lastSelectGender,
    ));
  }

  static XFile? image;

  imagePicker() async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: ImageSource.gallery) ?? image;
    emit(state.copyWith(image: image));
  }
}

extension Validator on String {
  bool isValidEmail() {
    return RegExp(r'\S+@\S+\.\S+').hasMatch(this);
  }

  bool isValidPhoneNumber() {
    if (length == 11) {
      return RegExp(r'(010|011|012|015)[0-9]{8}').hasMatch(this);
    }
    return false;
  }

  bool isValidName() {
    return RegExp(
            r'^[ا-ي]+\s[ا-ي]+\s[ا-ي]+|^[a-z|A-Z]+\s[a-z|A-Z]+\s[a-z|A-Z]+')
        .hasMatch(this);
  }
}
