class Converter {
  double convertAqiToPm25(int aqi) {
    if (aqi >= 0 && aqi <= 50) {
      return interpolate(aqi, 0, 50, 0.0, 12.0);
    } else if (aqi > 50 && aqi <= 100) {
      return interpolate(aqi, 51, 100, 12.1, 35.4);
    } else if (aqi > 100 && aqi <= 150) {
      return interpolate(aqi, 101, 150, 35.5, 55.4);
    } else if (aqi > 150 && aqi <= 200) {
      return interpolate(aqi, 151, 200, 55.5, 150.4);
    } else if (aqi > 200 && aqi <= 300) {
      return interpolate(aqi, 201, 300, 150.5, 250.4);
    } else if (aqi > 300 && aqi <= 500) {
      return interpolate(aqi, 301, 500, 250.5, 500.4);
    } else {
      return -1.0; // Invalid AQI value
    }
  }

  double interpolate(
      int aqi, int aqiLow, int aqiHigh, double concLow, double concHigh) {
    double conc =
        ((concHigh - concLow) / (aqiHigh - aqiLow)) * (aqi - aqiLow) + concLow;

    return conc;
  }

  String getAqiCategory(int aqi) {
    if (aqi >= 0 && aqi <= 50) {
      return "BAIK";
    } else if (aqi > 50 && aqi <= 100) {
      return "SEDANG";
    } else if (aqi > 100 && aqi <= 150) {
      return "TIDAK SEHAT BAGI KELOMPOK SENSITIF";
    } else if (aqi > 150 && aqi <= 200) {
      return "TIDAK SEHAT";
    } else if (aqi > 200 && aqi <= 300) {
      return "SANGAT TIDAK SEHAT";
    } else if (aqi > 300 && aqi <= 500) {
      return "BERBAHAYA";
    } else {
      return "Nilai AQI Tidak Valid";
    }
  }
}
