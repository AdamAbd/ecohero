import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'geolocator_state.dart';

class GeolocatorCubit extends Cubit<GeolocatorState> {
  GeolocatorCubit() : super(GeolocatorInitial());

  Future<void> getUserLocation({bool isReturningFromSettings = false}) async {
    // Check if location service is enabled
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      // Show dialog to enable location service
      print('Location service is disabled');

      emit(
        GeolocatorError(
            geolocatorErrorType: GeolocatorErrorType.location,
            title: "Location service is disabled",
            content: "Please enable location service and try again"),
      );
      return;
    }

    // Check location permission
    PermissionStatus permission = await Permission.location.status;

    if (permission.isDenied || permission.isRestricted) {
      // Request location permission only if user is not coming back from settings
      if (!isReturningFromSettings) {
        permission = await Permission.location.request();
      }
    }

    if (permission.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print('Gelocator Success ${position.latitude} ${position.longitude}');

      emit(
        GeolocatorSuccess(
            currentPosition: [position.latitude, position.longitude]),
      );
    } else {
      // Show dialog to request location permission only if user is coming back from settings
      if (isReturningFromSettings) {
        print('Location permission is not granted');

        emit(
          GeolocatorError(
            geolocatorErrorType: GeolocatorErrorType.permission,
            title: "Location permission is not granted",
            content:
                "Please grant location permission in app settings and try again",
          ),
        );
      }
    }
  }
}

enum GeolocatorErrorType { location, permission }
