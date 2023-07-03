import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class ChallengeDateTimeCubit extends Cubit<DateTimeRange> {
  ChallengeDateTimeCubit()
      : super(
          DateTimeRange(
            start: DateTime.now(),
            end: DateTime.now().add(const Duration(days: 1)),
          ),
        );

  void changeDateRange(DateTimeRange dateTimeRange) {
    emit(
      DateTimeRange(
        start: DateTime(
          dateTimeRange.start.year,
          dateTimeRange.start.month,
          dateTimeRange.start.day,
          state.start.hour,
          state.start.minute,
        ),
        end: DateTime(
          dateTimeRange.end.year,
          dateTimeRange.end.month,
          dateTimeRange.end.day,
          state.end.hour,
          state.end.minute,
        ),
      ),
    );
  }

  void changeTimeStart(TimeOfDay timeStart) {
    emit(
      DateTimeRange(
        start: DateTime(
          state.start.year,
          state.start.month,
          state.start.day,
          timeStart.hour,
          timeStart.minute,
        ),
        end: DateTime(
          state.end.year,
          state.end.month,
          state.end.day,
          state.end.hour,
          state.end.minute,
        ),
      ),
    );
  }

  void changeTimeEnd(TimeOfDay timeEnd) {
    emit(
      DateTimeRange(
        start: DateTime(
          state.start.year,
          state.start.month,
          state.start.day,
          state.start.hour,
          state.start.minute,
        ),
        end: DateTime(
          state.end.year,
          state.end.month,
          state.end.day,
          timeEnd.hour,
          timeEnd.minute,
        ),
      ),
    );
  }
}
