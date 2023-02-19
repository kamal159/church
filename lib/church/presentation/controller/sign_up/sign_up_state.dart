import 'package:chruch/core/utils/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/entities/school_grades.dart';

class SignUpState extends Equatable {
  final String uid;
  final RequestState requestState;
  final String errorMessage;

  final bool visible;
  final bool isServant;
  final int lastSelectSchool;

  final bool isExpanded;
  final int lastExpandedGrade;

  final int lastSelectGender;
  final XFile? image;
  final GeoPoint? position;
  final List<String> fathers;
  final String fatherName;

  final String schoolName;
  final int selectSchool;
  final int level;
  final int selectLevel;

  const SignUpState({
    this.uid = '',
    this.requestState = RequestState.waiting,
    this.errorMessage = '',
    this.schoolName = 'nursery',
    this.selectSchool = 0,
    this.level = 2,
    this.selectLevel = 0,
    this.visible = false,
    this.isServant = false,
    this.lastSelectSchool = -1,

    this.lastExpandedGrade = 0,
    this.isExpanded = false,
    this.lastSelectGender = -1,
    this.image,
    this.position,

    this.fathers = const [],
    this.fatherName = '',
  });

  SignUpState copyWith({
    String? uid,
    RequestState? requestState,
    String? errorMessage,

    bool? visible,
    bool? isServant,
    int? lastSelectSchool,
    int? lastExpandedGrade,
    bool? isExpanded,
    int? lastSelectGender,
    XFile? image,
    GeoPoint? position,
    List<String>? fathers,
    String? fatherName,

    String? schoolName,
    int? selectSchool,
    int? level,
    int? selectLevel,
  }) =>
      SignUpState(
        uid: uid ?? this.uid,
        requestState: requestState ?? this.requestState,
        errorMessage: errorMessage ?? this.errorMessage,

        visible: visible ?? this.visible,
        isServant: isServant ?? this.isServant,
        lastSelectSchool: lastSelectSchool ?? this.lastSelectSchool,
        lastExpandedGrade: lastExpandedGrade ?? this.lastExpandedGrade,
        isExpanded: isExpanded ?? this.isExpanded,
        lastSelectGender: lastSelectGender ?? this.lastSelectGender,
        image: image ?? this.image,
        position: position ?? this.position,

        fathers: fathers ?? this.fathers,
        fatherName: fatherName ?? this.fatherName,

        schoolName: schoolName ?? this.schoolName,
        selectSchool: selectSchool ?? this.selectSchool,
        level: level??this.level,
        selectLevel: selectLevel??this.selectLevel,
      );

  @override
  List<Object?> get props => [
    uid,
    requestState,
    errorMessage,
    visible,
    isServant,
    lastSelectSchool,
    lastExpandedGrade,
    isExpanded,
    lastSelectGender,
    image,
    position,
    fathers,
    fatherName,
    schoolName,
    selectSchool,
    level,
    selectLevel,
  ];
}

