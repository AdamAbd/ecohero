import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

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
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(backgroundImage: AssetImage(AppIcons.icon)),
                SizedBox(width: 8),
                Text(
                  'EcoHero',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Spacer(),
            Lottie.asset('assets/lottie/landscape.json'),
            const Spacer(),
            BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
              listener: (context, state) {
                if (state is GoogleAuthLoading) {
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

                if (state is GoogleAuthSuccess) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    PagePath.home,
                    (Route<dynamic> route) => false,
                  );
                } else if (state is GoogleAuthError) {
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
                return FilledButton.icon(
                  onPressed: () =>
                      context.read<GoogleAuthCubit>().googleSignIn(),
                  icon: SizedBox(
                    height: 24,
                    child: Image.asset('assets/icons/google.png'),
                  ),
                  label: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Masuk dengan Google',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
