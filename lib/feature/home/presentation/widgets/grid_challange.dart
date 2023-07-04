import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohero/feature/feature.dart';
import 'package:flutter/material.dart';

class GridChallange extends StatelessWidget {
  const GridChallange({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: StreamBuilder<QuerySnapshot>(
        stream: db.collection('challenge').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading');
          }

          List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 5 / 6,
            ),
            itemCount: data.length,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot<Object?> challenge = data[index];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PagePath.challengeDetail,
                    arguments: ChallengeDetailPageArgs(
                      title: challenge['title'],
                      desc: challenge['desc'],
                      image: challenge['image'],
                      point: challenge['point'],
                      startDate: challenge['date']['start'],
                      endDate: challenge['date']['end'],
                      userID: challenge['userID'],
                      index: index,
                    ),
                  );
                },
                child: Column(
                  children: [
                    Hero(
                      tag: 'imageHeroTransition_$index',
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.lightGreen[200],
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(challenge['image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      challenge['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.money),
                        const SizedBox(width: 2),
                        Text(
                          '${challenge['point']} | Diikuti 250+',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
