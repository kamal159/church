part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final RequestState requestState;
  final String errorMessage;

  const SplashState({
    this.requestState = RequestState.waiting,
    this.errorMessage = '',
  });

  SplashState copyWith({
    RequestState? requestState,
    String? errorMessage,
  }) =>
      SplashState(
        requestState: requestState ?? this.requestState,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object> get props => [
        requestState,
        errorMessage,
      ];
}
