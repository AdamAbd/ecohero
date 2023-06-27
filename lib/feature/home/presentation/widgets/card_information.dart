import 'package:android_intent_plus/android_intent.dart';
import 'package:ecohero/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/feature/feature.dart';
import 'package:permission_handler/permission_handler.dart';

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
                if (stateIQAir is GetIqairSuccess) {
                  print("Success");
                  aqius = stateIQAir.iqAirEntity.current!.pollution!.aqius ?? 0;
                  pm25 = Converter().convertAqiToPm25(aqius);
                } else if (stateIQAir is GetIqairError) {
                  print("Error");
                } else {
                  print("Loading");
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
                            Text('Jakarta Timur',
                                style: const TextStyle(fontSize: 14)),
                            // Text('${currentPosition?[0]}',
                            //     style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              Converter().getAqiCategory(aqius),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            Container(
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
                                      aqius.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const Text(
                                      "AQI",
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
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
                                      "${pm25.round()}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const Text(
                                      "PM 2.5",
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
