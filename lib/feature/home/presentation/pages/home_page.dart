import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

import 'package:ecohero/feature/home/presentation/screens/screens.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int index = 0;

  List<double>? currentPosition;

  Future<void> _getUserLocation({bool isReturningFromSettings = false}) async {
    // Check if location service is enabled
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      // Show dialog to enable location service
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Location service is disabled"),
            content: const Text("Please enable location service and try again"),
            actions: <Widget>[
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  const AndroidIntent intent = AndroidIntent(
                    action: 'android.settings.LOCATION_SOURCE_SETTINGS',
                  );
                  intent.launch();
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    // Check location permission
    PermissionStatus permission = await Permission.location.status;

    if (permission.isDenied || permission.isRestricted) {
      // Request location permission only if user is not coming back from settings
      if (!isReturningFromSettings) {
        permission = await Permission.location.request();
      }
    }

    if (permission.isGranted) {
      var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
      );

      setState(() {
        currentPosition = [position.latitude, position.longitude];
      });
    } else {
      // Show dialog to request location permission
      if (isReturningFromSettings) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Location permission is not granted"),
              content: const Text(
                  "Please grant location permission in app settings and try again"),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    openAppSettings();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getUserLocation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _getUserLocation(isReturningFromSettings: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (i) => setState(() {
            index = i;
          }),
          children: [
            DashboardScreen(
              currentPosition: currentPosition,
            ),
            const ChallengeScreen(),
            const ProfileScreen(),
          ],
        ),
      ),
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
