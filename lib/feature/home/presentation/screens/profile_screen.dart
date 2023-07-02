import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/locator.dart';
import 'package:ecohero/feature/feature.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          final DocumentReference documentReference = FirebaseFirestore.instance
              .collection('users')
              .doc(state.userEntity!.id);

          String vPoin = "";
          bool isLoading = false;

          return FutureBuilder<DocumentSnapshot>(
            future: documentReference.get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                vPoin = "Something went wrong";
                isLoading = false;
              } else if (snapshot.hasData && !snapshot.data!.exists) {
                vPoin = "Something went wrong";
                isLoading = false;
              } else if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                vPoin = data['poin'].toString();
                isLoading = false;
              } else {
                isLoading = true;
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(
                          state.userEntity?.photoURL ?? "",
                        ),
                      ),
                      const CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.amber,
                        child: Icon(Icons.edit_rounded, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.userEntity?.username ?? "",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    state.userEntity?.email ?? "",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Visibility(
                    visible: isLoading,
                    replacement: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal[800],
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: Text(
                        "$vPoin Poin",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: const ShimmerLayout(width: 100, height: 36),
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
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 60),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
