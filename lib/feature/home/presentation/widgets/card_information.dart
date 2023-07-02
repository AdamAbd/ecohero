import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:ecohero/feature/feature.dart';

class CardInformation extends StatelessWidget {
  const CardInformation({super.key});

  @override
  Widget build(BuildContext context) {
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
                          action: 'android.settings.LOCATION_SOURCE_SETTINGS',
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
            IQAirEntity iqAirEntity = IQAirEntity();
            AQICategoryEntity aqiCategoryEntity = AQICategoryEntity(
              value: "Nilai AQI Tidak Valid",
              color: const Color(0xff26B4A1),
              activities: [
                Activity(title: "Not Found", icon: Icons.error),
              ],
            );
            bool isLoading = false;

            if (stateIQAir is GetIqairSuccess) {
              iqAirEntity = stateIQAir.iqAirEntity;
              aqiCategoryEntity = Converter()
                  .getAqiCategory(iqAirEntity.current?.pollution?.aqius ?? 0);
              isLoading = false;
            } else if (stateIQAir is GetIqairError) {
              isLoading = false;
            } else {
              isLoading = true;
            }
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.place, size: 16),
                        Visibility(
                          visible: isLoading,
                          replacement: Text(
                            "Stasiun Terdekat : ${iqAirEntity.city}",
                            style: const TextStyle(fontSize: 14),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Visibility(
                          visible: isLoading,
                          replacement: SizedBox(
                            width: MediaQuery.of(context).size.width -
                                (56 * 2) -
                                (10 * 2) -
                                (14 * 2) -
                                (14 * 2),
                            child: Text(
                              aqiCategoryEntity.value,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          child: ShimmerLayout(
                              width: MediaQuery.of(context).size.width -
                                  (56 * 2) -
                                  (10 * 2) -
                                  (14 * 2) -
                                  (14 * 2),
                              height: 44),
                        ),
                        const SizedBox(width: 10),
                        Row(
                          children: [
                            InformationBox(
                              isLoading: isLoading,
                              title: "AQI",
                              value: "${iqAirEntity.current?.pollution?.aqius}",
                              color: aqiCategoryEntity.color,
                            ),
                            const SizedBox(width: 10),
                            InformationBox(
                              isLoading: isLoading,
                              title: "PM 2.5",
                              value: Converter()
                                  .convertAqiToPm25(
                                      iqAirEntity.current?.pollution?.aqius ??
                                          -1)
                                  .round()
                                  .toString(),
                              color: aqiCategoryEntity.color,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class InformationBox extends StatelessWidget {
  const InformationBox({
    super.key,
    required this.isLoading,
    required this.title,
    required this.value,
    required this.color,
  });

  final bool isLoading;
  final String title;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      replacement: Container(
        width: 56,
        height: 62,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 10, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      child: const ShimmerLayout(width: 56, height: 62),
    );
  }
}
