import 'package:ecohero/feature/feature.dart';
import 'package:flutter/material.dart';

class AQICategoryEntity {
  final String value;
  final Color color;
  final String assetName;
  final List<Activity> activities;

  AQICategoryEntity({
    required this.value,
    required this.color,
    required this.assetName,
    required this.activities,
  });
}
