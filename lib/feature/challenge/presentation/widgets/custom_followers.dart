import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:ecohero/feature/feature.dart';

class CustomFollowers extends StatelessWidget {
  const CustomFollowers({
    super.key,
    required this.db,
    required this.args,
  });

  final FirebaseFirestore db;
  final ChallengeDetailPageArgs args;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: StreamBuilder<QuerySnapshot>(
        stream: db
            .collection("challenge")
            .doc(args.docID)
            .collection("followers")
            .orderBy("timestamp", descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Stack(
                  children: List.generate(
                    min(5, data.length),
                    (index) {
                      return Container(
                        width: 28,
                        height: 28,
                        margin: EdgeInsets.only(left: index * 20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white),
                          image: DecorationImage(
                            image: NetworkImage(
                              data[index]["userPhotoURL"],
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  data.isEmpty
                      ? "Jadilah Yang Pertama Mengikuti Kompetisi Ini"
                      : "${data.length} Pengikut",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
