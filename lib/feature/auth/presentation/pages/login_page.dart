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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
                        title: Text("Loading"),
                        content: Text("Loading"),
                      );
                    },
                  );
                } else {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(PagePath.login),
                  );
                }

                if (state is GoogleSignInSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    PagePath.home,
                    (Route<dynamic> route) => false,
                  );
                } else if (state is GoogleSignInError) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialog(
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
