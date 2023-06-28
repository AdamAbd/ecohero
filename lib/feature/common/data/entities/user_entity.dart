import 'dart:convert';

enum UserRank { free, premium }

class UserEntity {
  final String id;
  final String username;
  final String email;
  final String photoURL;
  final DateTime updatedAt;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.photoURL,
    required this.updatedAt,
  });

  UserEntity copyWith({
    String? id,
    String? username,
    String? email,
    String? photoURL,
    String? rank,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'photoURL': photoURL,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      photoURL: map['photoURL'] ?? '',
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updatedAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserEntity.fromJson(String source) =>
      UserEntity.fromMap(json.decode(source));
}
