// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:chruch/core/global/components/components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:chruch/church/domain/entities/school_grades.dart';
import 'package:chruch/church/presentation/controller/sign_up/sign_up_event.dart';
import 'package:chruch/church/presentation/controller/sign_up/sign_up_state.dart';
import 'package:chruch/core/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../../domain/usecases/remote_usecase/get_fathers_usecase.dart';
import '../../../domain/usecases/remote_usecase/sign_up_usecase.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpUseCase signUpUseCase;
  final GetFathersUseCase getFathersUseCase;

  SignUpBloc(
    this.signUpUseCase,
    this.getFathersUseCase,
  ) : super(const SignUpState()) {
    on<SignUpUserEvent>(_signUp);
    on<GetFatherEvent>(_getFather);
  }

  static String? formattedDate;
  static String? password;

  int lastSelectGender = -1;
  static List<bool> genderSelections = List.generate(2, (index) => false);

  static List<String> levelGrades = [
    'اولي',
    'ثانية',
    'ثالثة',
    'رابعة',
    'خامسة',
    'سادسة',
    'سابعة',
  ];

  static bool? isMale;

  static List<SchoolGrade> schoolGradeModel = [
    SchoolGrade(
      levelCount: 2,
      arNameGrade: 'كي جي',
      enNameGrade: 'KG',
    ),
    SchoolGrade(
      levelCount: 6,
      arNameGrade: 'ابتدائية',
      enNameGrade: 'primary',
    ),
    SchoolGrade(
      levelCount: 3,
      arNameGrade: 'اعدادي',
      enNameGrade: 'preparatory',
    ),
    SchoolGrade(
      levelCount: 3,
      arNameGrade: 'ثانوية',
      enNameGrade: 'secondary',
    ),
    SchoolGrade(
      levelCount: 7,
      arNameGrade: 'جامعة',
      enNameGrade: 'collegiate',
    ),
    SchoolGrade(
      levelCount: 0,
      arNameGrade: 'خريجين',
      enNameGrade: 'graduate',
    ),
    SchoolGrade(
      levelCount: 0,
      arNameGrade: 'شباب (سمعان الشيخ)',
      enNameGrade: 'senior graduate',
    ),
  ];

  static List<bool> schoolSelections =
      List.generate(levelGrades.length, (index) => false);

  Future<FutureOr<void>> _signUp(
      SignUpUserEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(requestState: RequestState.loading));
    final result = await signUpUseCase(SignUpUseCaseParameters(
      level: event.level,
      name: event.name,
      date: event.date,
      fatherName: event.fatherName,
      email: event.email,
      phone: event.phone,
      password: event.password,
      school: event.school,
      isMale: event.isMale,
      isServant: event.isServant,
      img: event.img.path,
      position: event.position,
      address: event.address,
      userPath: event.userPath,
      isFather: false,
      isAdmin: false,
    ));
    result.fold(
      (l) {
        emit(state.copyWith(
            requestState: RequestState.error, errorMessage: l.message));
      },
      (r) {
        emit(state.copyWith(uid: r, requestState: RequestState.success));
      },
    );
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

  Future<void> determinePosition() async {
    final bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    final position = await Geolocator.getCurrentPosition();
    GeoPoint geoPoint = GeoPoint(position.latitude, position.longitude);

    emit(state.copyWith(position: geoPoint));
  }

  Future<FutureOr<void>> _getFather(
      GetFatherEvent event, Emitter<SignUpState> emit) async {
    final result = await getFathersUseCase(const NoParameters());
    result.fold((l) {
      toastShow(
          text: 'حدث خطأ يرجي الاتصال بالانترنت!', state: ToastStates.error);
    }, (r) {
      emit(state.copyWith(fathers: r, fatherName: r[0]));
    });
  }

  static String? fatherName;

  changeFatherName(String val) {
    fatherName = val;
    emit(state.copyWith(fatherName: val));
  }

  static int selectLevel = 0;

  changeGradeSchool(int level) {
    selectLevel = level;

    emit(state.copyWith(selectLevel: level));
  }

  static String schoolName = 'KG';
  static int? selectSchool;

  changeNameOfSchool(int index) {
    final schoolGrade = schoolGradeModel[index];

    schoolName = schoolGrade.enNameGrade;
    selectSchool = index;
    selectLevel = 0;

    emit(state.copyWith(
        schoolName: schoolGrade.enNameGrade,
        selectSchool: index,
        level: schoolGrade.levelCount,
        selectLevel: 0));
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
