import 'package:ecohero/feature/feature.dart';
import 'package:flutter/material.dart';

import '../locator.dart' as locator;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await locator.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eco Hero',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ExampleGeolocator(),
      // home: const LoginPage(),
    );
  }
}
