import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohero/feature/home/home.dart';
import 'package:flutter/material.dart';

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Papan Peringkat",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CardLeaderBoard(),
            StreamBuilder(
              stream: db
                  .collection('users')
                  .orderBy('poin', descending: true)
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
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index == 0 || index == 1 || index == 2) {
                      return const SizedBox();
                    }

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data[index]['photoURL']),
                      ),
                      title: Text(data[index]['username']),
                      subtitle: Text("Poin: ${data[index]['poin']}"),
                    );
                  },
                  itemCount: data.length,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
