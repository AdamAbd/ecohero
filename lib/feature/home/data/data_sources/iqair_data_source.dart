import 'package:dio/dio.dart';

import '../../../../feature/feature.dart';
import '../../../../core/core.dart';

class IQAirRemoteDataSource with BaseDataSource {
  final Dio dio;

  IQAirRemoteDataSource(this.dio);

  Future<ResponseModel<IQAirModel>> getPollution(
    List<double>? currentPosition,
  ) async {
    return dioCatchOrThrow(() async {
      final response = await dio.get(
        UrlConstant.getPollution,
        queryParameters: {
          "lat": currentPosition?[0],
          "lon": currentPosition?[1],
        },
      );

      return ResponseModel.fromJson(
        response.data as Map<String, dynamic>,
        generatedData: (data) {
          return IQAirModel.fromJson(data as Map<String, dynamic>);
        },
      );
    });
  }
}
