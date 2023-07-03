import 'package:ecohero/feature/feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChangeDateTimeRangeBottomSheet extends StatelessWidget {
  const ChangeDateTimeRangeBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeDateTimeCubit, DateTimeRange>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 22, top: 14, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Durasi',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Tutup',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: FilledButton.tonal(
                onPressed: () async {
                  final DateTimeRange? dateTimeRange =
                      await showDateRangePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(3023, 6, 1),
                    initialDateRange:
                        DateTimeRange(start: state.start, end: state.end),
                  );

                  if (dateTimeRange != null) {
                    context
                        .read<ChallengeDateTimeCubit>()
                        .changeDateRange(dateTimeRange);
                  }
                },
                child: Text(
                  "${DateFormat.yMMMd().format(state.start)} - ${DateFormat.yMMMd().format(state.end)}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: () async {
                        final TimeOfDay? timeStart = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (timeStart != null) {
                          context
                              .read<ChallengeDateTimeCubit>()
                              .changeTimeStart(timeStart);
                        }
                      },
                      child: Text(
                        DateFormat.jm().format(state.start),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton.tonal(
                      onPressed: () async {
                        final TimeOfDay? timeEnd = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (timeEnd != null) {
                          context
                              .read<ChallengeDateTimeCubit>()
                              .changeTimeEnd(timeEnd);
                        }
                      },
                      child: Text(
                        DateFormat.jm().format(state.end),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }
}
