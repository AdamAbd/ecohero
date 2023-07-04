part of 'challenge_image_cubit.dart';

abstract class ChallengeImagePickerState extends Equatable {
  const ChallengeImagePickerState();

  @override
  List<Object> get props => [];
}

class ChallengeImagePickerInitial extends ChallengeImagePickerState {}

class ChallengeImagePickerPicked extends ChallengeImagePickerState {
  const ChallengeImagePickerPicked({required this.image});

  final File image;

  @override
  List<Object> get props => [image];
}

class ChallengeImagePickerFailed extends ChallengeImagePickerState {
  const ChallengeImagePickerFailed({required this.errorMessage});

  final String errorMessage;
}
