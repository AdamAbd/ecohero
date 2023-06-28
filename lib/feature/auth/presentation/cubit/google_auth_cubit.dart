import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../feature/feature.dart';

part 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final GoogleAuthRepository googleAuthRepository;

  GoogleAuthCubit(this.googleAuthRepository) : super(GoogleAuthInitial());

  Future<void> googleSignIn() async {
    emit(GoogleAuthLoading());

    final Either<Failure, UserCredential> response =
        await googleAuthRepository.googleSignIn();

    emit(
      response.fold(
        (Failure failure) => GoogleAuthError(failure),
        (UserCredential user) => GoogleAuthSuccess(userCredential: user),
      ),
    );
  }

  Future<void> googleSignOut() async {
    emit(GoogleAuthLoading());

    await googleAuthRepository.googleSignOut();

    emit(const GoogleAuthSuccess());
  }
}
