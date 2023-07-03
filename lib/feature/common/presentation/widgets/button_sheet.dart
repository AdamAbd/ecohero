import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as context;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/feature/feature.dart';

extension CustomButtomSheet on context.BuildContext {
  void changeDateTime() {
    showModalBottomSheet(
      context: this,
      builder: (BuildContext context) {
        return Container(
          height: 160,
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Durasi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Tutup',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "DARI",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FilledButton.tonal(
                          onPressed: () async {
                            final DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(3023, 6, 1),
                            );
                            if (newDate != null) {
                              context
                                  .read<ChallengeDateTimeCubit>()
                                  .changeDateStart(newDate);
                            }

                            final TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (newTime != null) {
                              context
                                  .read<ChallengeDateTimeCubit>()
                                  .changeTimeStart(newTime);
                            }
                          },
                          child: BlocBuilder<ChallengeDateTimeCubit,
                              ChallengeDateTimeEntity>(
                            builder: (context, state) {
                              return Text(
                                DateTimeUtils().getDateTime(
                                  DateTime(
                                    state.selectedDateStart.year,
                                    state.selectedDateStart.month,
                                    state.selectedDateStart.day,
                                    state.selectedTimeStart.hour,
                                    state.selectedTimeStart.minute,
                                  ),
                                ),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_rounded),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "HINGGA",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FilledButton.tonal(
                          onPressed: () async {
                            final DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(3023, 6, 1),
                            );
                            if (newDate != null) {
                              context
                                  .read<ChallengeDateTimeCubit>()
                                  .changeDateEnd(newDate);
                            }

                            final TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now().addHour(5),
                            );
                            if (newTime != null) {
                              context
                                  .read<ChallengeDateTimeCubit>()
                                  .changeTimeEnd(newTime);
                            }
                          },
                          child: BlocBuilder<ChallengeDateTimeCubit,
                              ChallengeDateTimeEntity>(
                            builder: (context, state) {
                              return Text(
                                DateTimeUtils().getDateTime(
                                  DateTime(
                                    state.selectedDateEnd.year,
                                    state.selectedDateEnd.month,
                                    state.selectedDateEnd.day,
                                    state.selectedTimeEnd.hour,
                                    state.selectedTimeEnd.minute,
                                  ),
                                ),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
