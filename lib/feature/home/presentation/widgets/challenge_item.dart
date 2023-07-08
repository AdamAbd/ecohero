import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohero/feature/challenge/challenge.dart';
import 'package:ecohero/feature/common/common.dart';
import 'package:flutter/material.dart';

class ChallengeItem extends StatelessWidget {
  const ChallengeItem({
    Key? key,
    required this.desc,
    required this.image,
    required this.dateTime,
    required this.userID,
    required this.docID,
    required this.tapMessage,
  }) : super(key: key);

  final String desc;
  final String image;
  final DateTime dateTime;
  final String userID;
  final String docID;
  final VoidCallback tapMessage;

  // point: challenge['point'],
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return FutureBuilder<DocumentSnapshot>(
      future: db.collection('users').doc(userID).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }

        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(data['photoURL'].toString()),
                          ),
                          shape: BoxShape.circle,
                        ),
                      )
                      // Container(
                      //   width: 1,
                      //   height: 200,
                      //   margin: const EdgeInsets.symmetric(vertical: 8),
                      //   color: Colors.grey,
                      // ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: MediaQuery.of(context).size.width -
                        (2 * 14) -
                        (2 * 18) -
                        12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['username'].toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          desc,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          height: 240,
                          margin: const EdgeInsets.only(top: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              splashRadius: 1,
                              icon: const Icon(Icons.favorite),
                            ),
                            IconButton(
                              onPressed: tapMessage,
                              splashRadius: 1,
                              icon: const Icon(Icons.comment),
                            ),
                            IconButton(
                              onPressed: () {},
                              splashRadius: 1,
                              icon: const Icon(Icons.report),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection("challenge")
                  .doc(docID)
                  .collection("followers")
                  .orderBy("timestamp", descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;

                if (data.isEmpty) {
                  return const SizedBox();
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Row(
                        children: [
                          Stack(
                            children: List.generate(
                              min(3, data.length),
                              (index) {
                                return Container(
                                  width: 20,
                                  height: 20,
                                  margin: EdgeInsets.only(left: index * 14),
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
                          const SizedBox(width: 8),
                          const Text(
                            "Tampilkan balasan",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                  ],
                );
              },
            ),
            const Divider(),
            const SizedBox(height: 14),
          ],
        );
      },
    );
  }
}
