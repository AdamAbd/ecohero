import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ecohero/feature/feature.dart';
import '../locator.dart' as locator;
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await locator.init();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PageRouter router = PageRouter();

    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: locator.sl<UserCubit>(),
        ),
        BlocProvider.value(
          value: locator.sl<GoogleAuthCubit>(),
        ),
        BlocProvider.value(
          value: locator.sl<GeolocatorCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'Eco Hero',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: router.getRoute,
        // home: const LoginPage(),
      ),
    );
  }
}
