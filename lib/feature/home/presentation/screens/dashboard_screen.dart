import 'package:flutter/material.dart';
import 'package:ecohero/locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/feature/feature.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GetIqairCubit>(),
      child: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CardInformation(),
                const SizedBox(height: 12),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "Rekomendasi Aktifitas",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const CustomActivities(),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Papan Peringkat',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          PagePath.leaderboard,
                        ),
                        child: const Text(
                          'Lainnya',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const CardLeaderBoard(),
                const SizedBox(height: 18),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    'Statistik Challenge',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(14),
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xff26B4A1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Transportasi",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Asap Pabrik",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Listrik Terbuang",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Asap Pembakaran",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width -
                                (2 * 14) -
                                (2 * 14) -
                                130,
                            lineHeight: 20.0,
                            percent: 0.9,
                            barRadius: const Radius.circular(12),
                            progressColor: const Color(0xff26B4A1),
                            center: const Text("90%"),
                          ),
                          const SizedBox(height: 10),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width -
                                (2 * 14) -
                                (2 * 14) -
                                130,
                            lineHeight: 20.0,
                            percent: 0.8,
                            barRadius: const Radius.circular(12),
                            progressColor: const Color(0xff26B4A1),
                            center: const Text("80%"),
                          ),
                          const SizedBox(height: 10),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width -
                                (2 * 14) -
                                (2 * 14) -
                                130,
                            lineHeight: 20.0,
                            percent: 0.5,
                            barRadius: const Radius.circular(12),
                            progressColor: const Color(0xff26B4A1),
                            center: const Text("50%"),
                          ),
                          const SizedBox(height: 10),
                          LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width -
                                (2 * 14) -
                                (2 * 14) -
                                130,
                            lineHeight: 20.0,
                            percent: 0.3,
                            barRadius: const Radius.circular(12),
                            progressColor: const Color(0xff26B4A1),
                            center: const Text("30%"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
