import 'package:ecohero/feature/common/common.dart';
import 'package:flutter/material.dart';

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

  AQICategoryEntity getAqiCategory(int aqi) {
    if (aqi >= 0 && aqi <= 50) {
      return AQICategoryEntity(
        value: "BAIK",
        color: const Color(0xffA9D663),
      );
    } else if (aqi > 50 && aqi <= 100) {
      return AQICategoryEntity(
        value: "SEDANG",
        color: const Color(0xffE7C047),
      );
    } else if (aqi > 100 && aqi <= 150) {
      return AQICategoryEntity(
        value: "TIDAK SEHAT BAGI KELOMPOK SENSITIF",
        color: const Color(0xffEB9558),
      );
    } else if (aqi > 150 && aqi <= 200) {
      return AQICategoryEntity(
        value: "TIDAK SEHAT",
        color: const Color(0xffE46864),
      );
    } else if (aqi > 200 && aqi <= 300) {
      return AQICategoryEntity(
        value: "SANGAT TIDAK SEHAT",
        color: const Color(0xff9972B2),
      );
    } else if (aqi > 300 && aqi <= 500) {
      return AQICategoryEntity(
        value: "BERBAHAYA",
        color: const Color(0xff986C7B),
      );
    } else {
      return AQICategoryEntity(
        value: "Nilai AQI Tidak Valid",
        color: const Color(0xff26B4A1),
      );
    }
  }
}
