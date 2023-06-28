import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/feature/feature.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            const Text(
              'Eco Hero',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            const FlutterLogo(size: 400),
            const SizedBox(height: 60),
            BlocConsumer<GoogleSignInCubit, GoogleSignInState>(
              listener: (context, state) {
                if (state is GoogleSignInLoading) {
                  print('Sign In Loading');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Loading"),
                        content: Text("Loading"),
                      );
                    },
                  );
                } else {
                  Navigator.popUntil(context, (route) => route.isFirst);
                }

                if (state is GoogleSignInSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } else if (state is GoogleSignInError) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Failed"),
                        content: Text("Failed"),
                      );
                    },
                  );
                }
              },
              builder: (context, state) {
                return FilledButton(
                  onPressed: () =>
                      context.read<GoogleSignInCubit>().signInWithGoogle(),
                  // onPressed: () => Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const HomePage()),
                  // ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.flutter_dash),
                      SizedBox(width: 8),
                      Text(
                        'Masuk Sekarang',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
