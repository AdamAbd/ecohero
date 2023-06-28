part of 'user_cubit.dart';

class UserState extends Equatable {
  final UserEntity? userEntity;
  final bool isAlreadyLogin;

  const UserState({this.userEntity, required this.isAlreadyLogin});

  @override
  List<Object?> get props => <Object?>[userEntity, isAlreadyLogin];

  // UserState copyWith({
  //   UserEntity? userEntity,
  //   bool? isAlreadyLogin,
  // }) {
  //   return UserState(
  //     userEntity: userEntity ?? this.userEntity,
  //     isAlreadyLogin: isAlreadyLogin ?? this.isAlreadyLogin,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     'userEntity': userEntity?.toMap(),
  //     'isAlreadyLogin': isAlreadyLogin,
  //   };
  // }

  // factory UserState.fromMap(Map<String, dynamic> map) {
  //   return UserState(
  //     userEntity: map['userEntity'] != null
  //         ? UserEntity.fromMap(map['userEntity'])
  //         : null,
  //     isAlreadyLogin: map['isAlreadyLogin'],
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory UserState.fromJson(String source) =>
  //     UserState.fromMap(json.decode(source));

  UserState copyWith({
    UserEntity? userEntity,
    bool? isAlreadyLogin,
  }) {
    return UserState(
      userEntity: userEntity ?? this.userEntity,
      isAlreadyLogin: isAlreadyLogin ?? this.isAlreadyLogin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userEntity': userEntity?.toMap(),
      'isAlreadyLogin': isAlreadyLogin,
    };
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      userEntity: map['userEntity'] != null
          ? UserEntity.fromMap(map['userEntity'])
          : null,
      isAlreadyLogin: map['isAlreadyLogin'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserState.fromJson(String source) =>
      UserState.fromMap(json.decode(source));
}
