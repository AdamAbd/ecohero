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
        int aqius = 0;
        List<Activity> activities = [];
        bool isLoading = false;

        if (state is GetIqairSuccess) {
          aqius = state.iqAirEntity.current!.pollution!.aqius ?? 0;
          if (aqius >= 0 && aqius <= 50) {
            activities = RecommendedActivites.recommendedActivites.good;
          } else if (aqius > 50 && aqius <= 100) {
            activities = RecommendedActivites.recommendedActivites.moderate;
          } else if (aqius > 100 && aqius <= 150) {
            activities = RecommendedActivites
                .recommendedActivites.unhealthyForVulnerablePeople;
          } else if (aqius > 150 && aqius <= 200) {
            activities = RecommendedActivites.recommendedActivites.unhealthy;
          } else if (aqius > 200 && aqius <= 300) {
            activities =
                RecommendedActivites.recommendedActivites.veryUnhealthy;
          } else if (aqius > 300 && aqius <= 500) {
            activities = RecommendedActivites.recommendedActivites.dangerous;
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
                itemCount: isLoading ? 3 : activities.length,
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

                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 14 : 0,
                      right: index == (activities.length - 1) ? 14 : 12,
                    ),
                    child: InkWell(
                      onTap: () => setState(() {
                        newIndex = index;
                      }),
                      child: Container(
                        width: 86,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color:
                              index == newIndex ? Colors.green : Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.green,
                            width: index != newIndex ? 4 : 0,
                          ),
                        ),
                        child: Icon(
                          activities[index].icon,
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
                        activities[newIndex].title,
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
