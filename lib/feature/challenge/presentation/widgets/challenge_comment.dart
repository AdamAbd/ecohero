import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChallengeComment extends StatelessWidget {
  const ChallengeComment({
    super.key,
    required this.userID,
    required this.isLastItem,
  });

  final String userID;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return Column(
      children: [
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: FutureBuilder(
            future: db.collection('users').doc(userID).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
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
                        image: NetworkImage(data!['photoURL'].toString()),
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
        ),
        isLastItem ? const Divider() : const SizedBox(),
      ],
    );
  }
}
