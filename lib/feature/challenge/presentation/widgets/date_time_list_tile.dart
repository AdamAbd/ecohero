import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/feature/feature.dart';

class DateTimeListTile extends StatelessWidget {
  const DateTimeListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeDateTimeCubit, DateTimeRange>(
      builder: (context, state) {
        return ListTile(
          leading: const Icon(Icons.calendar_month, size: 28),
          title: Text(
            "${DateTimeUtils().getDateTime(state.start)} ➡ ${DateTimeUtils().getDateTime(state.end)}",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          onTap: () => showModalBottomSheet(
            context: context,
            builder: (_) {
              return BlocProvider.value(
                value: context.read<ChallengeDateTimeCubit>(),
                child: const ChangeDateTimeRangeBottomSheet(),
              );
            },
          ),
        );
      },
    );
  }
}
