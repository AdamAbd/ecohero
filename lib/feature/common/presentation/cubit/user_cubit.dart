import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../../feature/feature.dart';

part 'user_state.dart';

class UserCubit extends HydratedCubit<UserState> {
  UserCubit() : super(const UserState(isAlreadyLogin: false));

  Future<void> save({
    required UserEntity userEntity,
    required bool isAlreadyLogin,
  }) async {
    emit(state.copyWith(
      userEntity: userEntity,
      isAlreadyLogin: isAlreadyLogin,
    ));
  }

  Future<void> remove() async {
    emit(const UserState(isAlreadyLogin: false));

    clear();
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    try {
      return UserState(
        userEntity: UserEntity.fromMap(
          jsonDecode(json['userEntity'].toString()) as Map<String, dynamic>,
        ),
        isAlreadyLogin: json['isAlreadyLogin'],
      );
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    try {
      return <String, dynamic>{
        'userEntity': state.userEntity,
        'isAlreadyLogin': state.isAlreadyLogin,
      };
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
