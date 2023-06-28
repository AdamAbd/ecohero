import 'package:get_it/get_it.dart';

import 'package:ecohero/core/core.dart';
import 'package:ecohero/feature/feature.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// User
  sl.registerLazySingleton(() => UserCubit());

  /// Firebase Auth With Google
  sl.registerLazySingleton(() => GoogleAuthRemoteDataSource());
  sl.registerLazySingleton(() => GoogleAuthRepository(sl()));
  sl.registerFactory(() => GoogleAuthCubit(sl()));

  /// Dio
  sl.registerLazySingleton(() => DioClient.dioInit());

  /// IQ Air
  sl.registerLazySingleton(() => IQAirRepository(sl()));
  sl.registerLazySingleton(() => IQAirRemoteDataSource(sl()));
  sl.registerFactory(() => GetIqairCubit(sl()));

  /// Geolocator
  sl.registerFactory(() => GeolocatorCubit());
}
