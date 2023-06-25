import 'package:dio/dio.dart';

import '../../../../feature/feature.dart';
import '../../../../core/core.dart';

class IQAirRemoteDataSource with BaseDataSource {
  final Dio dio;

  IQAirRemoteDataSource(this.dio);

  Future<ResponseModel<IQAirModel>> getPollution() async {
    return dioCatchOrThrow(() async {
      final response = await dio.get(UrlConstant.getPollution);

      return ResponseModel.fromJson(
        response.data as Map<String, dynamic>,
        generatedData: (data) {
          return IQAirModel.fromJson(data as Map<String, dynamic>);
        },
      );
    });
  }
}
