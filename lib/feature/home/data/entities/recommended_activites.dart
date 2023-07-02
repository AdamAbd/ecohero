import 'package:flutter/material.dart';

class RecommendedActivites {
  List<Activity> good;
  List<Activity> moderate;
  List<Activity> unhealthyForVulnerablePeople;
  List<Activity> unhealthy;
  List<Activity> veryUnhealthy;
  List<Activity> dangerous;

  RecommendedActivites({
    required this.good,
    required this.moderate,
    required this.unhealthyForVulnerablePeople,
    required this.unhealthy,
    required this.veryUnhealthy,
    required this.dangerous,
  });

  static final RecommendedActivites recommendedActivites = RecommendedActivites(
    good: [
      Activity(title: "Berlari", icon: Icons.directions_run),
      Activity(title: "Bersepeda", icon: Icons.directions_bike),
      Activity(title: "Main Tenis", icon: Icons.sports_tennis),
      Activity(title: "Naik Gunung", icon: Icons.hiking),
    ],
    moderate: [
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
    unhealthyForVulnerablePeople: [
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
    unhealthy: [
      Activity(
        title: "Pakai masker ketika berkegiatan",
        icon: Icons.masks_outlined,
      ),
      Activity(
        title:
            "Tidak diperbolehkan berkegiatan diluar khusus memiliki masalah pernapasan",
        icon: Icons.do_not_step_rounded,
      ),
      Activity(
        title: "Tutup jendela",
        icon: Icons.balcony,
      ),
      Activity(title: "Nyalakan Air Purifier", icon: Icons.air),
    ],
    veryUnhealthy: [
      Activity(
        title: "Pakai masker",
        icon: Icons.masks_outlined,
      ),
      Activity(
        title: "Tidak diperbolehkan berkegiatan diluar",
        icon: Icons.do_not_step_rounded,
      ),
      Activity(
        title: "Tutup jendela",
        icon: Icons.balcony,
      ),
      Activity(title: "Nyalakan Air Purifier", icon: Icons.air),
    ],
    dangerous: [
      Activity(
        title: "Tinggal dirumah dan hindari semua aktivitas fisik",
        icon: Icons.do_not_step_rounded,
      ),
    ],
  );
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
