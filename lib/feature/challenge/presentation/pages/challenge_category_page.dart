import 'package:flutter/material.dart';

class ChallengeCategoryPage extends StatelessWidget {
  const ChallengeCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kategori Challenge",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          Container(
            color: Colors.amber,
          ),
          Container(
            color: Colors.amber,
          ),
          Container(
            color: Colors.amber,
          ),
          Container(
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}
