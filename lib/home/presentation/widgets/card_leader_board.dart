import 'package:flutter/material.dart';

class CardLeaderBoard extends StatelessWidget {
  const CardLeaderBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const CircleAvatar(radius: 36),
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  width: 36,
                  child: const Text(
                    'Adam Abdurrahman',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                const CircleAvatar(radius: 50),
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  width: 48,
                  child: const Text(
                    'Adam Abdurrahman',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                const CircleAvatar(radius: 36),
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  width: 36,
                  child: const Text(
                    'Adam Abdurrahman',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
