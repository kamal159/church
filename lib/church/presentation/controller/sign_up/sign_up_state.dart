import 'package:chruch/core/utils/enums.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';


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

  const SignUpState({
    this.uid = '',
    this.requestState = RequestState.waiting,
    this.errorMessage = '',

    this.visible = false,
    this.isServant = false,
    this.lastSelectSchool = -1,

    this.lastExpandedGrade = 0,
    this.isExpanded = false,
    this.lastSelectGender = -1,
    this.image,
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
  ];
}

