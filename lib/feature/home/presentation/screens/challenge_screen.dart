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
          SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // BackButton(color: Colors.white),
                Text(
                  'Challenge', // Your AppBar title
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
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
