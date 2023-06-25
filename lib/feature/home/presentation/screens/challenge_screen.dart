import 'package:flutter/material.dart';

import 'package:ecohero/feature/home/presentation/widgets/widgets.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          CardLeaderBoard(),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Challange',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          GridChallange(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
