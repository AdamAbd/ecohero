import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:ecohero/feature/feature.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),
          StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection('challenge')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading');
                }

                List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot<Object?> challenge = data[index];

                    return ChallengeItem(
                      desc: challenge['desc'],
                      image: challenge['image'],
                      dateTime: DateTime.now(),
                      userID: challenge['userID'],
                      docID: challenge.id,
                    );
                  },
                  itemCount: data.length,
                );
              }),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
