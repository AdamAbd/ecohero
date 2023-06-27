import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'geolocator_state.dart';

// class GeolocatorCubit extends Cubit<GeolocatorState> {
//   GeolocatorCubit() : super(GeolocatorInitial());
// }

class GeolocatorCubit extends Cubit<List<double>?> {
  GeolocatorCubit() : super(null);

  Future<void> getUserLocation({bool isReturningFromSettings = false}) async {
    // Check if location service is enabled
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      // Show dialog to enable location service
      print('Location service is disabled');
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
      emit([position.latitude, position.longitude]);
    } else {
      // Show dialog to request location permission only if user is coming back from settings
      if (isReturningFromSettings) {
        print('Location permission is not granted');
      }
    }
  }
}
