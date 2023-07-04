import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

part 'challenge_image_picker_state.dart';

class ChallengeImagePickerCubit extends Cubit<ChallengeImagePickerState> {
  ChallengeImagePickerCubit() : super(ChallengeImagePickerInitial());

  final picker = ImagePicker();

  Future<void> pickImageFrom(ImageSource source) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile == null) return;

      emit(ChallengeImagePickerPicked(image: File(pickedFile.path)));
    } on PlatformException catch (e) {
      emit(
        ChallengeImagePickerFailed(
            errorMessage: "Failed to pick image from ${source.name}: $e"),
      );
    }
  }
}
