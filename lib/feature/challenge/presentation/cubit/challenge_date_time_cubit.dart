import 'package:ecohero/feature/feature.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ChallengeDateTimeCubit extends Cubit<ChallengeDateTimeEntity> {
  ChallengeDateTimeCubit()
      : super(
          ChallengeDateTimeEntity(
            selectedDateStart: DateTime.now(),
            selectedTimeStart: TimeOfDay.now(),
            selectedDateEnd: DateTime.now(),
            selectedTimeEnd: TimeOfDay.now().addHour(5),
          ),
        );

  void changeDateStart(DateTime dateStart, TimeOfDay timeStart) => emit(
        ChallengeDateTimeEntity(
          selectedDateStart: dateStart,
          selectedTimeStart: timeStart,
          selectedDateEnd: state.selectedDateEnd,
          selectedTimeEnd: state.selectedTimeEnd,
        ),
      );
}
