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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
