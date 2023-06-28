import '../../../../feature/feature.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String photoURL;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.photoURL,
    required this.updatedAt,
  });

  UserEntity toUserEntity() => UserEntity(
        id: id,
        username: username,
        email: email,
        photoURL: photoURL,
        updatedAt: updatedAt,
      );
}
