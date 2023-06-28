import 'package:ecohero/locator.dart';
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
                  final UserEntity userEntity = UserEntity(
                    id: state.userCredential!.user!.uid,
                    username: state.userCredential!.user!.displayName ?? '',
                    email: state.userCredential!.user!.email ?? '',
                    photoURL: state.userCredential!.user!.photoURL ?? '',
                    updatedAt: DateTime.now(),
                  );

                  sl<UserCubit>().save(
                    userEntity: userEntity,
                    isAlreadyLogin: true,
                  );

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
                return FilledButton(
                  onPressed: () =>
                      context.read<GoogleAuthCubit>().googleSignIn(),
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
