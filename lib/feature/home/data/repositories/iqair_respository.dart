import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../../../../feature/feature.dart';

class IQAirRepository with BaseRepository {
  final IQAirRemoteDataSource iqAirRemoteDataSource;

  IQAirRepository(this.iqAirRemoteDataSource);

  Future<Either<Failure, ResponseEntity<IQAirEntity>>> getPollution() async {
    return catchOrThrow(() async {
      final response = await iqAirRemoteDataSource.getPollution();

      return ResponseEntity.fromResponseModel(
        response,
        data: response.data?.toIQAirEntity(),
      );
    });
  }
}
