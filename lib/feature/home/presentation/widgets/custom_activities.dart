import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/feature/feature.dart';

class CustomActivities extends StatefulWidget {
  const CustomActivities({super.key});

  @override
  State<CustomActivities> createState() => _CustomActivitiesState();
}

class _CustomActivitiesState extends State<CustomActivities> {
  int newIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetIqairCubit, GetIqairState>(
      builder: (context, state) {
        AQICategoryEntity aqiCategoryEntity = AQICategoryEntity(
          value: "Nilai AQI Tidak Valid",
          color: const Color(0xff26B4A1),
          activities: [
            Activity(title: "Not Found", icon: Icons.error),
          ],
        );
        bool isLoading = false;

        if (state is GetIqairSuccess) {
          int aqius = state.iqAirEntity.current!.pollution!.aqius ?? 0;

          if (aqius >= 0 && aqius <= 500) {
            aqiCategoryEntity = Converter().getAqiCategory(
                state.iqAirEntity.current?.pollution?.aqius ?? 0);
          } else {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              child: const Center(
                child: Text(
                  "Nilai AQI Tidak Valid",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          isLoading = false;
        } else if (state is GetIqairError) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            child: const Center(
              child: Text(
                "Error",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          isLoading = true;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount:
                    isLoading ? 3 : (aqiCategoryEntity.activities.length + 1),
                itemBuilder: (context, index) {
                  if (isLoading) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 14 : 0,
                        right: index == 2 ? 14 : 12,
                      ),
                      child: const ShimmerLayout(width: 90, height: 80),
                    );
                  }

                  if (index == aqiCategoryEntity.activities.length) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 14),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: 86,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: aqiCategoryEntity.color,
                              width: 4,
                            ),
                          ),
                          child: const Icon(
                            Icons.smart_toy,
                            size: 36,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }

                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 14 : 0,
                      right: 12,
                    ),
                    child: InkWell(
                      onTap: () => setState(() {
                        newIndex = index;
                      }),
                      child: Container(
                        width: 86,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: index == newIndex
                              ? aqiCategoryEntity.color
                              : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: aqiCategoryEntity.color,
                            width: index != newIndex ? 4 : 0,
                          ),
                        ),
                        child: Icon(
                          aqiCategoryEntity.activities[index].icon,
                          size: 36,
                          color:
                              index != newIndex ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 8,
              ),
              child: isLoading
                  ? const ShimmerLayout(width: double.infinity, height: 24)
                  : Center(
                      child: Text(
                        aqiCategoryEntity.activities[newIndex].title,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ],
        );
      },
    );
  }
}
