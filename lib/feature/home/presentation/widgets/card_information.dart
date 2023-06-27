import 'package:android_intent_plus/android_intent.dart';
import 'package:ecohero/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:ecohero/feature/feature.dart';

class CardInformation extends StatelessWidget {
  const CardInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GetIqairCubit>(),
      child: Builder(builder: (context) {
        return BlocConsumer<GeolocatorCubit, GeolocatorState>(
          listener: (context, state) {
            if (state is GeolocatorError) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(state.title),
                    content: Text(state.content),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Ok'),
                        onPressed: () {
                          if (state.geolocatorErrorType ==
                              GeolocatorErrorType.location) {
                            const AndroidIntent intent = AndroidIntent(
                              action:
                                  'android.settings.LOCATION_SOURCE_SETTINGS',
                            );
                            intent.launch();
                            Navigator.of(context, rootNavigator: true).pop();
                          } else {
                            openAppSettings();
                            Navigator.of(context, rootNavigator: true).pop();
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
          builder: (context, stateGeolocator) {
            if (stateGeolocator is GeolocatorSuccess) {
              context
                  .read<GetIqairCubit>()
                  .getPollution(stateGeolocator.currentPosition);
            }
            return BlocBuilder<GetIqairCubit, GetIqairState>(
              builder: (context, stateIQAir) {
                int aqius = 0;
                double pm25 = 0;
                String city = "";
                bool isLoading = false;
                if (stateIQAir is GetIqairSuccess) {
                  aqius = stateIQAir.iqAirEntity.current!.pollution!.aqius ?? 0;
                  pm25 = Converter().convertAqiToPm25(aqius);
                  city = stateIQAir.iqAirEntity.city ?? "";
                  isLoading = false;
                } else if (stateIQAir is GetIqairError) {
                  isLoading = false;
                } else {
                  isLoading = true;
                }
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.place, size: 16),
                            Visibility(
                              visible: isLoading,
                              replacement: SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    (56 * 2) -
                                    (10 * 2) -
                                    (24 * 2) -
                                    (14 * 2),
                                child: Text(
                                  city,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              child: const ShimmerLayout(
                                width: 120,
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Visibility(
                              visible: isLoading,
                              replacement: SizedBox(
                                width: MediaQuery.of(context).size.width -
                                    (56 * 2) -
                                    (10 * 2) -
                                    (24 * 2) -
                                    (14 * 2),
                                child: Text(
                                  Converter().getAqiCategory(aqius),
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              child: ShimmerLayout(
                                  width: MediaQuery.of(context).size.width -
                                      (56 * 2) -
                                      (10 * 2) -
                                      (24 * 2) -
                                      (14 * 2),
                                  height: 44),
                            ),
                            const SizedBox(width: 10),
                            Visibility(
                              visible: isLoading,
                              replacement: InformationBox(
                                title: "AQI",
                                value: aqius.toString(),
                              ),
                              child: const ShimmerLayout(width: 56, height: 52),
                            ),
                            const SizedBox(width: 10),
                            Visibility(
                              visible: isLoading,
                              replacement: InformationBox(
                                title: "PM 2.5",
                                value: pm25.round().toString(),
                              ),
                              child: const ShimmerLayout(width: 56, height: 52),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Divider(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Jumlah poin anda 100",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.money, size: 18)
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}

class InformationBox extends StatelessWidget {
  const InformationBox({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2.5,
          color: Colors.green,
          strokeAlign: BorderSide.strokeAlignCenter,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
