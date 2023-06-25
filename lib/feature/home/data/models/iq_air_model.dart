import 'package:ecohero/feature/feature.dart';

class IQAirModel {
  String? city;
  String? state;
  String? country;
  LocationModel? location;
  CurrentModel? current;

  IQAirModel(
      {this.city, this.state, this.country, this.location, this.current});

  factory IQAirModel.fromJson(Map<String, dynamic> json) => IQAirModel(
        city: json['city'] as String?,
        state: json['state'] as String?,
        country: json['country'] as String?,
        location: json['location'] == null
            ? null
            : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
        current: json['current'] == null
            ? null
            : CurrentModel.fromJson(json['current'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'city': city,
        'state': state,
        'country': country,
        'location': location?.toJson(),
        'current': current?.toJson(),
      };

  IQAirEntity toIQAirEntity() => IQAirEntity(
        city: city,
        state: state,
        country: country,
        location: location?.toLocationEntity(),
        current: current?.toCurrentEntity(),
      );
}

class LocationModel {
  String? type;
  // List<double>? coordinates;

  LocationModel({this.type});
  // LocationModel({this.type, this.coordinates});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        type: json['type'] as String?,
        // coordinates: json['coordinates'] as List<double>?,
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        // 'coordinates': coordinates,
      };

  LocationEntity toLocationEntity() => LocationEntity(
        type: type,
        coordinates: [0.1, 0.2],
      );
}

class CurrentModel {
  PollutionModel? pollution;
  WeatherModel? weather;

  CurrentModel({this.pollution, this.weather});

  factory CurrentModel.fromJson(Map<String, dynamic> json) => CurrentModel(
        pollution: json['pollution'] == null
            ? null
            : PollutionModel.fromJson(
                json['pollution'] as Map<String, dynamic>),
        weather: json['weather'] == null
            ? null
            : WeatherModel.fromJson(json['weather'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'pollution': pollution?.toJson(),
        'weather': weather?.toJson(),
      };

  CurrentEntity toCurrentEntity() => CurrentEntity(
        pollution: pollution?.toPollutionEntity(),
        weather: weather?.toWeatherEntity(),
      );
}

class PollutionModel {
  DateTime? ts;
  int? aqius;
  String? mainus;
  int? aqicn;
  String? maincn;

  PollutionModel({this.ts, this.aqius, this.mainus, this.aqicn, this.maincn});

  factory PollutionModel.fromJson(Map<String, dynamic> json) => PollutionModel(
        ts: json['ts'] == null ? null : DateTime.parse(json['ts'] as String),
        aqius: json['aqius'] as int?,
        mainus: json['mainus'] as String?,
        aqicn: json['aqicn'] as int?,
        maincn: json['maincn'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ts': ts?.toIso8601String(),
        'aqius': aqius,
        'mainus': mainus,
        'aqicn': aqicn,
        'maincn': maincn,
      };

  PollutionEntity toPollutionEntity() => PollutionEntity(
        ts: ts,
        aqius: aqius,
        mainus: mainus,
        aqicn: aqicn,
        maincn: maincn,
      );
}

class WeatherModel {
  DateTime? ts;
  int? tp;
  int? pr;
  int? hu;
  double? ws;
  int? wd;
  String? ic;

  WeatherModel({this.ts, this.tp, this.pr, this.hu, this.ws, this.wd, this.ic});

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        ts: json['ts'] == null ? null : DateTime.parse(json['ts'] as String),
        tp: json['tp'] as int?,
        pr: json['pr'] as int?,
        hu: json['hu'] as int?,
        ws: (json['ws'] as num?)?.toDouble(),
        wd: json['wd'] as int?,
        ic: json['ic'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'ts': ts?.toIso8601String(),
        'tp': tp,
        'pr': pr,
        'hu': hu,
        'ws': ws,
        'wd': wd,
        'ic': ic,
      };

  WeatherEntity toWeatherEntity() => WeatherEntity(
        ts: ts,
        tp: tp,
        pr: pr,
        hu: hu,
        ws: ws,
        wd: wd,
        ic: ic,
      );
}
