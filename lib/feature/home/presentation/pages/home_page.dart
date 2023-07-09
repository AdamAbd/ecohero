import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/feature/feature.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int index = 0;

  List<Widget> appbars = [
    const DashBoardAppBar(),
    const Text(
      "Challenge",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
    const Text(
      "Profil",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<GeolocatorCubit>().getUserLocation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context
          .read<GeolocatorCubit>()
          .getUserLocation(isReturningFromSettings: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Scaffold(
      appBar: AppBar(
        title: appbars[index],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Container(
            color: Colors.black12,
            height: 2,
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (i) => setState(() {
            index = i;
          }),
          children: const [
            DashboardScreen(),
            ChallengeScreen(),
            ProfileScreen(),
          ],
        ),
      ),
      floatingActionButton: index == 1
          ? FloatingActionButton(
              onPressed: () => Navigator.pushNamed(
                context,
                PagePath.challengeCategory,
              ),
              tooltip: 'Create Challenge',
              backgroundColor: Colors.teal[800],
              child: const Icon(Icons.add, size: 28, color: Colors.white),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
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

class DashBoardAppBar extends StatelessWidget {
  const DashBoardAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(state.userEntity!.photoURL),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8),
              width: 240,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hai ${state.userEntity!.username}!",
                    maxLines: 1,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    "mari perbaiki kualitas udara sekitar.",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        );
      },
    );
  }
}
