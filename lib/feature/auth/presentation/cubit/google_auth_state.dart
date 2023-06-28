part of 'google_auth_cubit.dart';

abstract class GoogleAuthState extends Equatable {
  const GoogleAuthState();

  @override
  List<Object> get props => [];
}

class GoogleAuthInitial extends GoogleAuthState {}

class GoogleAuthLoading extends GoogleAuthState {}

class GoogleAuthError extends GoogleAuthState {
  final Failure failure;

  const GoogleAuthError(this.failure);
}

class GoogleAuthSuccess extends GoogleAuthState {
  final UserCredential? userCredential;

  const GoogleAuthSuccess({this.userCredential});
}
