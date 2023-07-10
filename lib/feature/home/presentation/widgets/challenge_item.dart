import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChallengeItem extends StatelessWidget {
  const ChallengeItem({
    Key? key,
    required this.desc,
    required this.image,
    required this.dateTime,
    required this.type,
    required this.userID,
    required this.docID,
    required this.index,
    required this.isLastIndex,
    required this.tapMessage,
  }) : super(key: key);

  final String desc;
  final String image;
  final DateTime dateTime;
  final String type;
  final String userID;
  final String docID;
  final int index;
  final bool isLastIndex;
  final VoidCallback tapMessage;

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

        return GestureDetector(
          onTap: tapMessage,
          child: Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLastIndex
                    ? const Column(
                        children: [
                          Divider(),
                          SizedBox(height: 14),
                        ],
                      )
                    : const SizedBox(),
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
                                image:
                                    NetworkImage(data['photoURL'].toString()),
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
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
                            Row(
                              children: [
                                Text(
                                  data['username'].toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  "7 jam",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
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
                            Hero(
                              tag: "imageHeroTransition_$index",
                              child: Container(
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
                                const Spacer(),
                                Container(
                                  width: 130,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  margin: const EdgeInsets.only(left: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff26B4A1)
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    type,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                      .collection("comments")
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

                    List<QueryDocumentSnapshot<Object?>> data =
                        snapshot.data!.docs;

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
                                    return FutureBuilder(
                                      future: db
                                          .collection('users')
                                          .doc(data[index]['userID'])
                                          .get(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              'Something went wrong');
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text('Loading');
                                        }

                                        Map<String, dynamic>? userData =
                                            snapshot.data!.data();
                                        return Container(
                                          width: 20,
                                          height: 20,
                                          margin:
                                              EdgeInsets.only(left: index * 14),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                                Border.all(color: Colors.white),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                userData!['photoURL']
                                                    .toString(),
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
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
              ],
            ),
          ),
        );
      },
    );
  }
}
