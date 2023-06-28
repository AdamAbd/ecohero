import 'package:ecohero/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/feature/feature.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(
                  'https://www.goodnewsfromindonesia.id/uploads/images/2021/01/2016332021-Pict.-Tersenyum.jpg',
                ),
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: Colors.amber,
                child: Icon(Icons.edit_rounded, size: 18),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Adam Abdurrahman',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          const Text(
            'adam@adam.com',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
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
                  ModalRoute.withName(PagePath.home),
                );
              }

              if (state is GoogleAuthSuccess) {
                sl<UserCubit>().remove();

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  PagePath.login,
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
                    context.read<GoogleAuthCubit>().googleSignOut(),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              );
            },
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
