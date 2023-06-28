part of 'google_sign_in_cubit.dart';

abstract class GoogleSignInState extends Equatable {
  const GoogleSignInState();

  @override
  List<Object> get props => [];
}

class GoogleSignInInitial extends GoogleSignInState {}

class GoogleSignInLoading extends GoogleSignInState {}

class GoogleSignInError extends GoogleSignInState {
  final Failure failure;

  const GoogleSignInError(this.failure);
}

class GoogleSignInSuccess extends GoogleSignInState {
  final UserCredential? userCredential;

  const GoogleSignInSuccess({this.userCredential});
}
