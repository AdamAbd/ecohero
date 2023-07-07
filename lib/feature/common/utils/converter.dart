import 'package:ecohero/feature/feature.dart';
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
        value: "Baik",
        color: const Color(0xff93CC4B),
        assetName: AppIllustration.backgroud1,
        activities: [
          Activity(title: "Berlari", icon: Icons.directions_run),
          Activity(title: "Bersepeda", icon: Icons.directions_bike),
          Activity(title: "Main Tenis", icon: Icons.sports_tennis),
          Activity(title: "Naik Gunung", icon: Icons.hiking),
        ],
      );
    } else if (aqi > 50 && aqi <= 100) {
      return AQICategoryEntity(
        value: "Sedang",
        color: const Color(0xffFFCF23),
        assetName: AppIllustration.backgroud2,
        activities: [
          Activity(
            title:
                "Pakai masker ketika berkegiatan diluar khusus memiliki masalah pernapasan",
            icon: Icons.masks_outlined,
          ),
          Activity(
            title: "Tutup jendela khusus memiliki masalah pernapasan",
            icon: Icons.balcony,
          ),
          Activity(title: "Nyalakan Air Purifier jika perlu", icon: Icons.air),
        ],
      );
    } else if (aqi > 100 && aqi <= 150) {
      return AQICategoryEntity(
        value: "Tidak Sehat untuk Kelompok Sensitif",
        color: const Color(0xffFEA120),
        assetName: AppIllustration.backgroud3,
        activities: [
          Activity(
            title: "Pakai masker khusus memiliki masalah pernapasan",
            icon: Icons.masks_outlined,
          ),
          Activity(
            title: "Batasi kegiatan diluar khusus memiliki masalah pernapasan",
            icon: Icons.do_not_step_rounded,
          ),
          Activity(
            title: "Tutup jendela khusus memiliki masalah pernapasan",
            icon: Icons.balcony,
          ),
          Activity(title: "Nyalakan Air Purifier", icon: Icons.air),
        ],
      );
    } else if (aqi > 150 && aqi <= 200) {
      return AQICategoryEntity(
        value: "Buruk",
        color: const Color(0xffDC0703),
        assetName: AppIllustration.backgroud4,
        activities: [
          Activity(
            title: "Pakai masker ketika berkegiatan",
            icon: Icons.masks_outlined,
          ),
          Activity(
            title:
                "Tidak diperbolehkan berkegiatan diluar khusus memiliki masalah pernapasan",
            icon: Icons.do_not_step_rounded,
          ),
          Activity(title: "Tutup jendela", icon: Icons.balcony),
          Activity(title: "Nyalakan Air Purifier", icon: Icons.air),
        ],
      );
    } else if (aqi > 200 && aqi <= 300) {
      return AQICategoryEntity(
        value: "Sangat Buruk",
        color: const Color(0xff5B255F),
        assetName: AppIllustration.backgroud5,
        activities: [
          Activity(title: "Pakai masker", icon: Icons.masks_outlined),
          Activity(
            title: "Tidak diperbolehkan berkegiatan diluar",
            icon: Icons.do_not_step_rounded,
          ),
          Activity(title: "Tutup jendela", icon: Icons.balcony),
          Activity(title: "Nyalakan Air Purifier", icon: Icons.air),
        ],
      );
    } else if (aqi > 300 && aqi <= 500) {
      return AQICategoryEntity(
        value: "Berbahaya",
        color: const Color(0xff722221),
        assetName: AppIllustration.backgroud6,
        activities: [
          Activity(
            title: "Tinggal dirumah dan hindari semua aktivitas fisik",
            icon: Icons.do_not_step_rounded,
          ),
        ],
      );
    } else {
      return AQICategoryEntity(
        value: "Nilai AQI Tidak Valid",
        color: const Color(0xff26B4A1),
        assetName: AppIllustration.backgroud1,
        activities: [
          Activity(title: "Not Found", icon: Icons.error),
        ],
      );
    }
  }
}

class Activity {
  String title;
  IconData icon;
  String? iconPath;

  Activity({
    required this.title,
    required this.icon,
    this.iconPath,
  });
}
