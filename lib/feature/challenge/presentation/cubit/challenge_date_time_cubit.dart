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

  void changeDateStart(DateTime dateStart) => emit(
        ChallengeDateTimeEntity(
          selectedDateStart: dateStart,
          selectedTimeStart: state.selectedTimeStart,
          selectedDateEnd: state.selectedDateEnd,
          selectedTimeEnd: state.selectedTimeEnd,
        ),
      );

  void changeTimeStart(TimeOfDay timeStart) => emit(
        ChallengeDateTimeEntity(
          selectedDateStart: state.selectedDateStart,
          selectedTimeStart: timeStart,
          selectedDateEnd: state.selectedDateEnd,
          selectedTimeEnd: state.selectedTimeEnd,
        ),
      );

  void changeDateEnd(DateTime dateEnd) => emit(
        ChallengeDateTimeEntity(
          selectedDateStart: state.selectedDateStart,
          selectedTimeStart: state.selectedTimeStart,
          selectedDateEnd: dateEnd,
          selectedTimeEnd: state.selectedTimeEnd,
        ),
      );

  void changeTimeEnd(TimeOfDay timeEnd) => emit(
        ChallengeDateTimeEntity(
          selectedDateStart: state.selectedDateStart,
          selectedTimeStart: state.selectedTimeStart,
          selectedDateEnd: state.selectedDateEnd,
          selectedTimeEnd: timeEnd,
        ),
      );
}
