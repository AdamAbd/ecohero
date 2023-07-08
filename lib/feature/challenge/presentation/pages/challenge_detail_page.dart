import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/feature/feature.dart';

class ChallengeDetailPageArgs {
  const ChallengeDetailPageArgs({
    required this.title,
    required this.desc,
    required this.image,
    required this.point,
    required this.startDate,
    required this.endDate,
    required this.userID,
    required this.docID,
    required this.index,
  });

  final String title;
  final String desc;
  final String image;
  final int point;
  final Timestamp startDate;
  final Timestamp endDate;
  final String userID;
  final String docID;
  final int index;
}

class ChallengeDetailPage extends StatefulWidget {
  const ChallengeDetailPage({required this.args, super.key});

  final ChallengeDetailPageArgs args;

  @override
  State<ChallengeDetailPage> createState() => _ChallengeDetailPageState();
}

class _ChallengeDetailPageState extends State<ChallengeDetailPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.args.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: FutureBuilder(
                  future: db.collection('users').doc(widget.args.userID).get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading');
                    }

                    Map<String, dynamic>? data = snapshot.data!.data();
                    return Row(
                      children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(data!['photoURL'].toString()),
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          data['username'].toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "7 jam",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black45,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                widget.args.desc,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Hero(
              tag: "imageHeroTransition_${widget.args.index}",
              child: Container(
                height: 260,
                margin: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(widget.args.image),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    splashRadius: 1,
                    icon: const Icon(Icons.favorite),
                  ),
                  IconButton(
                    onPressed: () {},
                    splashRadius: 1,
                    icon: const Icon(Icons.comment),
                  ),
                  IconButton(
                    onPressed: () {},
                    splashRadius: 1,
                    icon: const Icon(Icons.report),
                  ),
                ],
              ),
            ),
            const Divider(),
            StreamBuilder<QuerySnapshot>(
              stream: db
                  .collection('challenge')
                  .doc(widget.args.docID)
                  .collection('followers')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text('Loading');
                }

                List<QueryDocumentSnapshot<Object?>> dataStream =
                    snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    QueryDocumentSnapshot<Object?> followers =
                        dataStream[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: FutureBuilder(
                        future: db
                            .collection('users')
                            .doc(followers['userID'])
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Loading');
                          }

                          Map<String, dynamic>? data = snapshot.data!.data();
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        data!['photoURL'].toString()),
                                  ),
                                  shape: BoxShape.circle,
                                ),
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
                                      'Komen',
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
                                          image: NetworkImage(
                                            'https://www.goodnewsfromindonesia.id/uploads/images/2021/01/2016332021-Pict.-Tersenyum.jpg',
                                          ),
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
                                          onPressed: () {},
                                          splashRadius: 1,
                                          icon: const Icon(Icons.report),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                  itemCount: dataStream.length,
                );
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
