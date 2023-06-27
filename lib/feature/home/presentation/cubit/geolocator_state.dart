part of 'geolocator_cubit.dart';

abstract class GeolocatorState extends Equatable {
  const GeolocatorState();

  @override
  List<Object> get props => [];
}

class GeolocatorInitial extends GeolocatorState {}

class GeolocatorLoading extends GeolocatorState {}

class GeolocatorError extends GeolocatorState {
  final GeolocatorErrorType geolocatorErrorType;
  final String title;
  final String content;

  const GeolocatorError({
    required this.geolocatorErrorType,
    required this.title,
    required this.content,
  });
}

class GeolocatorSuccess extends GeolocatorState {
  final List<double> currentPosition;

  const GeolocatorSuccess({required this.currentPosition});
}
