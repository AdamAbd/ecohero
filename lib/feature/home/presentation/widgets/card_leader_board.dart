import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardLeaderBoard extends StatelessWidget {
  const CardLeaderBoard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: StreamBuilder(
            stream: db
                .collection('users')
                .orderBy('poin', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Loading');
              }

              List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 42,
                        backgroundImage: NetworkImage(data[1]['photoURL']),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 4),
                        width: 84,
                        alignment: Alignment.center,
                        child: Text(
                          data[1]['username'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(data[0]['photoURL']),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 4),
                        width: 100,
                        alignment: Alignment.center,
                        child: Text(
                          data[0]['username'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 36,
                        backgroundImage: NetworkImage(data[2]['photoURL']),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 4),
                        width: 72,
                        alignment: Alignment.center,
                        child: Text(
                          data[2]['username'],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}
