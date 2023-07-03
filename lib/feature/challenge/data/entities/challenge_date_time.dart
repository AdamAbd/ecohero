import 'package:flutter/material.dart';

class ChallengeDateTimeEntity {
  const ChallengeDateTimeEntity({
    required this.selectedDateStart,
    required this.selectedTimeStart,
    required this.selectedDateEnd,
    required this.selectedTimeEnd,
  });

  /// Date Start
  final DateTime selectedDateStart;
  final TimeOfDay selectedTimeStart;

  /// Date End
  final DateTime selectedDateEnd;
  final TimeOfDay selectedTimeEnd;

  ChallengeDateTimeEntity copyWith({
    DateTime? selectedDateStart,
    TimeOfDay? selectedTimeStart,
    DateTime? selectedDateEnd,
    TimeOfDay? selectedTimeEnd,
  }) {
    return ChallengeDateTimeEntity(
      selectedDateStart: selectedDateStart ?? this.selectedDateStart,
      selectedTimeStart: selectedTimeStart ?? this.selectedTimeStart,
      selectedDateEnd: selectedDateEnd ?? this.selectedDateEnd,
      selectedTimeEnd: selectedTimeEnd ?? this.selectedTimeEnd,
    );
  }
}
