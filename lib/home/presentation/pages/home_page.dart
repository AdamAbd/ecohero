import 'package:flutter/material.dart';

import 'package:ecohero/home/presentation/screens/screens.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          children: [
            const DashboardScreen(),
            Container(color: Colors.amber),
            Container(color: Colors.greenAccent),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Utama",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forest),
            label: "Challenge",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
