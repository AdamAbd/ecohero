import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohero/feature/common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                leading: IconButton.filled(
                  onPressed: () => Navigator.pop(context),
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white54),
                  ),
                  icon: const Icon(Icons.arrow_back),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Hero(
                    tag: 'imageHeroTransition_${widget.args.index}',
                    child: Image.network(
                      widget.args.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    widget.args.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.monetization_on,
                        size: 20,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${widget.args.point} Poin",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 6)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.timeline,
                        size: 20,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Berulang Setiap Hari",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 6)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 20,
                        color: Colors.black54,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${DateTimeUtils().getDateTime(widget.args.startDate.toDate()).toString()} ➡ ${DateTimeUtils().getDateTime(widget.args.endDate.toDate()).toString()}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 6)),
              SliverToBoxAdapter(
                child: FutureBuilder<QuerySnapshot>(
                  future: db
                      .collection('challenge')
                      .doc(widget.args.docID)
                      .collection("followers")
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading');
                    }

                    List<QueryDocumentSnapshot<Object?>> data =
                        snapshot.data!.docs;

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
                                        data[index]['userPhotoURL'],
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
                            data.length <= 0
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
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    "Deskripsi",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 6)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Text(
                    widget.args.desc,
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
            ],
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            color: Colors.white,
            child: widget.args.userID ==
                    context.read<UserCubit>().state.userEntity!.id
                ? FilledButton.tonal(
                    onPressed: () {},
                    child: const Text(
                      "EDIT TANTANGAN",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : Row(
                    children: [
                      SizedBox(
                        width: 72,
                        child: IconButton.filled(
                          onPressed: () {},
                          icon: const Icon(Icons.report),
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            final Map<String, dynamic> followers =
                                <String, dynamic>{
                              'userID': context
                                  .read<UserCubit>()
                                  .state
                                  .userEntity!
                                  .id,
                              "userPhotoURL": context
                                  .read<UserCubit>()
                                  .state
                                  .userEntity!
                                  .photoURL,
                              'timestamp': Timestamp.now(),
                            };

                            db
                                .collection('challenge')
                                .doc(widget.args.docID)
                                .collection('followers')
                                .add(followers)
                                .then((DocumentReference doc) {
                              print(doc.id);
                              setState(() {});
                            });
                          },
                          child: const Text(
                            "IKUTI TANTANGAN",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
