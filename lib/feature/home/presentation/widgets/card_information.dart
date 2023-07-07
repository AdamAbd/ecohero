import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
              color: const Color(0xff93CC4B),
              assetName: AppIllustration.backgroud1,
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
            return GestureDetector(
              onTap: () => context.read<GeolocatorCubit>().getUserLocation(),
              child: Container(
                width: double.infinity,
                height: 290,
                decoration: BoxDecoration(
                  color: aqiCategoryEntity.color,
                  image: DecorationImage(
                    image: AssetImage(aqiCategoryEntity.assetName),
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 32,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Terakhir Diperbarui",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                DateFormat("HH:mm, d MMM yyyy")
                                    .format(DateTime.now()),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Visibility(
                                visible: isLoading,
                                replacement: Text(
                                  iqAirEntity.current?.pollution?.aqius
                                          .toString() ??
                                      "0",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                child: const ShimmerLayout(
                                  width: 38,
                                  height: 28,
                                ),
                              ),
                              const Text(
                                "AQI US",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Column(
                            children: [
                              Visibility(
                                visible: isLoading,
                                replacement: Text(
                                  Converter()
                                      .convertAqiToPm25(iqAirEntity
                                              .current?.pollution?.aqius ??
                                          -1)
                                      .round()
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                child: const ShimmerLayout(
                                  width: 38,
                                  height: 28,
                                ),
                              ),
                              const Text(
                                "PM2.5",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 26),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.place,
                                color: Colors.white,
                                size: 18,
                              ),
                              const SizedBox(width: 2),
                              Visibility(
                                visible: isLoading,
                                replacement: Row(
                                  children: [
                                    Text(
                                      "${iqAirEntity.city?.toUpperCase()} ",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Text(
                                      "(Stasiun Terdekat)",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                child: const ShimmerLayout(
                                  width: 140,
                                  height: 18,
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: isLoading,
                            replacement: Text(
                              aqiCategoryEntity.value.contains("untuk")
                                  ? "Buruk"
                                  : aqiCategoryEntity.value.contains("Nilai")
                                      ? "Nilai AQI"
                                      : aqiCategoryEntity.value,
                              style: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: ShimmerLayout(
                                width: 150,
                                height: 36,
                              ),
                            ),
                          ),
                          aqiCategoryEntity.value.contains("untuk") ||
                                  aqiCategoryEntity.value.contains("Nilai")
                              ? Text(
                                  aqiCategoryEntity.value.substring(
                                    aqiCategoryEntity.value.contains("untuk")
                                        ? 11
                                        : 9,
                                  ),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
