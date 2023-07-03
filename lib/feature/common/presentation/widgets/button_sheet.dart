import 'package:ecohero/feature/common/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as context;

extension CustomButtomSheet on context.BuildContext {
  void changeDateTime({
    required DateTime selectedDateStart,
    required TimeOfDay selectedTimeStart,
    required DateTime selectedDateEnd,
    required TimeOfDay selectedTimeEnd,
  }) {
    showModalBottomSheet(
      context: this,
      builder: (BuildContext context) {
        return Container(
          height: 200,
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
                              // setState(() {
                              //   selectedDateStart = newDate;
                              // });
                            }

                            final TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTimeStart,
                            );
                            if (newTime != null) {
                              // setState(() {
                              //   selectedTimeStart = newTime;
                              // });
                            }
                          },
                          child: Text(
                            DateTimeUtils().getDateTime(
                              DateTime(
                                selectedDateStart.year,
                                selectedDateStart.month,
                                selectedDateStart.day,
                                selectedTimeStart.hour,
                                selectedTimeStart.minute,
                              ),
                            ),
                            style: const TextStyle(fontWeight: FontWeight.w500),
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
                              // setState(() {
                              //   selectedDateEnd = newDate;
                              // });
                            }

                            final TimeOfDay? newTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTimeStart.addHour(5),
                            );
                            if (newTime != null) {
                              // setState(() {
                              //   selectedTimeEnd = newTime;
                              // });
                            }
                          },
                          child: Text(
                            DateTimeUtils().getDateTime(
                              DateTime(
                                selectedDateEnd.year,
                                selectedDateEnd.month,
                                selectedDateEnd.day,
                                selectedTimeEnd.hour,
                                selectedTimeEnd.minute,
                              ),
                            ),
                            style: const TextStyle(fontWeight: FontWeight.w500),
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
