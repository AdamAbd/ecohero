import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:ecohero/locator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../feature/feature.dart';

part 'google_auth_state.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final GoogleAuthRepository googleAuthRepository;
  FirebaseFirestore db = FirebaseFirestore.instance;

  GoogleAuthCubit(this.googleAuthRepository) : super(GoogleAuthInitial());

  Future<void> googleSignIn() async {
    emit(GoogleAuthLoading());

    final Either<Failure, UserCredential> response =
        await googleAuthRepository.googleSignIn();

    emit(
      response.fold(
        (Failure failure) => GoogleAuthError(failure),
        (UserCredential user) {
          final UserEntity userEntity = UserEntity(
            id: user.user!.uid,
            username: user.user!.displayName!,
            email: user.user!.email!,
            photoURL: user.user!.photoURL!,
          );

          _createUser(userEntity).onError(
            (e, _) =>
                GoogleAuthError(Failure(message: "Error writing document: $e")),
          );

          sl<UserCubit>().save(
            userEntity: userEntity,
            isAlreadyLogin: true,
          );

          return GoogleAuthSuccess(userCredential: user);
        },
      ),
    );
  }

  Future<void> _createUser(UserEntity userEntity) async {
    DocumentReference userDocRef = db.collection('users').doc(userEntity.id);

    return db.runTransaction((transaction) async {
      // Get the document
      DocumentSnapshot snapshot = await transaction.get(userDocRef);

      if (!snapshot.exists) {
        // If the document does not exist, then create it with the poin and updatedAt field
        transaction.set(userDocRef, {
          ...userEntity.toMap(),
          'poin': 0,
          'updatedAt': DateTime.now(),
        });
      } else {
        // If the document already exists, then update it without the poin and updatedAt field
        transaction.update(userDocRef, userEntity.toMap());
      }
    });
  }

  Future<void> googleSignOut() async {
    emit(GoogleAuthLoading());

    await googleAuthRepository.googleSignOut();

    emit(const GoogleAuthSuccess());
  }
}
