/// List Of Constant URL
mixin UrlConstant {
  /// IQAir KEY
  static const String iqAirKey = "6ea4b713-2839-4d43-bb46-b3a06ef2d2f6";

  /// Base URL
  static const String baseUrl = 'https://api.airvisual.com/v2/';

  /// IQAir Nearest City
  // static const String getPollution =
  //     '${baseUrl}nearest_city?lat=-6.379162&lon=106.81787&key=$iqAirKey';
  static const String getPollution = '${baseUrl}nearest_city?key=$iqAirKey';
}
