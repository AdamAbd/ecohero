class IQAirEntity {
  String? city;
  String? state;
  String? country;
  LocationEntity? location;
  CurrentEntity? current;

  IQAirEntity({
    this.city,
    this.state,
    this.country,
    this.location,
    this.current,
  });
}

class LocationEntity {
  String? type;
  List<double>? coordinates;

  LocationEntity({this.type, this.coordinates});
}

class CurrentEntity {
  PollutionEntity? pollution;
  WeatherEntity? weather;

  CurrentEntity({this.pollution, this.weather});
}

class PollutionEntity {
  DateTime? ts;
  int? aqius;
  String? mainus;
  int? aqicn;
  String? maincn;

  PollutionEntity({this.ts, this.aqius, this.mainus, this.aqicn, this.maincn});
}

class WeatherEntity {
  DateTime? ts;
  int? tp;
  int? pr;
  int? hu;
  double? ws;
  int? wd;
  String? ic;

  WeatherEntity({
    this.ts,
    this.tp,
    this.pr,
    this.hu,
    this.ws,
    this.wd,
    this.ic,
  });
}
