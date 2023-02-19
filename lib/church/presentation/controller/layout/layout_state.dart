import 'package:chruch/church/data/models/verified_user_model.dart';
import 'package:chruch/core/utils/enums.dart';
import 'package:equatable/equatable.dart';

class LayoutState extends Equatable {
  final RequestState userRequestState;
  final String errorMessage;
  final VerifiedUserModel? userModel;

  const LayoutState({
    this.userRequestState= RequestState.waiting,
    this.userModel,
    this.errorMessage = '',
  });
  LayoutState copyWith({
    RequestState? userRequestState,
    VerifiedUserModel? userModel,
    String? errorMessage,
}) => LayoutState(
    userRequestState: userRequestState?? this.userRequestState,
    userModel: userModel?? this.userModel,
    errorMessage: errorMessage?? this.errorMessage,
  );
  @override
  List<Object?> get props => [
    userRequestState,
    userModel,
    errorMessage,
  ];
}
