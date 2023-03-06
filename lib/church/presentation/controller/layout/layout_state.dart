import 'package:chruch/church/data/models/user_data_models/user_data_model.dart';
import 'package:chruch/core/utils/enums.dart';
import 'package:equatable/equatable.dart';

class LayoutState extends Equatable {
  final RequestState userRequestState;
  final String errorMessage;
  final UserDataModel? userModel;

  const LayoutState({
    this.userRequestState= RequestState.loading,
    this.userModel,
    this.errorMessage = '',
  });
  LayoutState copyWith({
    RequestState? userRequestState,
    UserDataModel? userModel,
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
