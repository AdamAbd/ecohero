import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/core.dart';
import '../../../../feature/feature.dart';

class GoogleAuthRepository with BaseRepository {
  final GoogleAuthRemoteDataSource _remoteDataSource;

  GoogleAuthRepository(this._remoteDataSource);

  Future<Either<Failure, UserCredential>> googleSignIn() async {
    try {
      final UserCredential response = await _remoteDataSource.googleSignIn();

      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message.toString()));
    }
  }

  Future<void> googleSignOut() async {
    await _remoteDataSource.googleSignOut();
  }
}
