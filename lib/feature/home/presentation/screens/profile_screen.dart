import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/locator.dart';
import 'package:ecohero/feature/feature.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    /// User
    UserEntity? userEntity = context.read<UserCubit>().state.userEntity;

    /// Poin
    String vPoin = "";
    bool isLoading = false;

    return SingleChildScrollView(
      child: FutureBuilder<DocumentSnapshot>(
        future: db.collection('users').doc(userEntity?.id).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                      userEntity?.photoURL ?? "",
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
                userEntity?.username ?? "",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
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
              const SizedBox(height: 18),
              GestureDetector(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const ListTile(
                    leading: Icon(Icons.shop),
                    title: Text("Toko"),
                    subtitle: Text("Tukarkan Poin Anda"),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const ListTile(
                  leading: Icon(Icons.group),
                  title: Text("Tentang Kami"),
                  subtitle: Text("Cari tahu lebih banyak"),
                ),
              ),
              const SizedBox(height: 24),
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
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      PagePath.login,
                      (Route<dynamic> route) => false,
                    );

                    sl<UserCubit>().remove();
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
                  return GestureDetector(
                    onTap: () =>
                        context.read<GoogleAuthCubit>().googleSignOut(),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: const Color(0xff26B4A1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const ListTile(
                        leading: Icon(Icons.logout),
                        title: Text("Keluar"),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
