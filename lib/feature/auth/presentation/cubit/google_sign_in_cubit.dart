import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../feature/feature.dart';

part 'google_sign_in_state.dart';

class GoogleSignInCubit extends Cubit<GoogleSignInState> {
  final GoogleSignInRepository googleSignInRepository;

  GoogleSignInCubit(this.googleSignInRepository) : super(GoogleSignInInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoading());

    final Either<Failure, UserCredential> response =
        await googleSignInRepository.googleSignIn();

    emit(
      response.fold(
        (Failure failure) => GoogleSignInError(failure),
        (UserCredential user) => GoogleSignInSuccess(userCredential: user),
      ),
    );
  }

  Future<void> signOutFromGoogle() async {
    emit(GoogleSignInLoading());

    await googleSignInRepository.googleSignOut();

    emit(const GoogleSignInSuccess());
  }
}
