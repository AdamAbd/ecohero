import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohero/locator.dart';
import 'package:flutter/material.dart';

import 'package:ecohero/feature/feature.dart';

class ChallengeDetailPageArgs {
  const ChallengeDetailPageArgs({
    required this.title,
    required this.desc,
    required this.image,
    required this.point,
    required this.date,
    required this.type,
    required this.userID,
    required this.docID,
    required this.index,
  });

  final String title;
  final String desc;
  final String image;
  final int point;
  final Timestamp date;
  final String type;
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
  FirebaseFirestore db = FirebaseFirestore.instance;

  final chatController = TextEditingController();

  @override
  void dispose() {
    chatController.clear();
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusUtils(context).unfocus(),
      child: Scaffold(
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
                    future:
                        db.collection('users').doc(widget.args.userID).get(),
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
                                image:
                                    NetworkImage(data!['photoURL'].toString()),
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
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      margin: const EdgeInsets.only(left: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xff26B4A1).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.args.type,
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
              ),
              const Divider(),
              StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection('challenge')
                    .doc(widget.args.docID)
                    .collection('comments')
                    .orderBy('timestamp', descending: false)
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

                      return FutureBuilder(
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

                          Map<String, dynamic>? users = snapshot.data!.data();

                          if (users!['isDeleted']) {
                            return const SizedBox();
                          }

                          return ChallengeComment(
                            userID: followers['userID'],
                            msg: followers['msg'],
                            isLastItem: (dataStream.length - 1) != index,
                          );
                        },
                      );
                    },
                    itemCount: dataStream.length,
                  );
                },
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
        bottomSheet: BottomSheet(
          shape: const Border(top: BorderSide.none),
          onClosing: () {},
          builder: (context) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, bottom: 10),
                    width:
                        MediaQuery.of(context).size.width - (2 * 14) - 6 - 50,
                    child: TextField(
                      controller: chatController,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        fillColor: Colors.black12,
                        filled: true,
                        focusColor: Colors.amber,
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black12,
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.black12,
                            width: 0,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: 'Ketik Pesan',
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: IconButton.filled(
                      onPressed: () {
                        if (chatController.text.isNotEmpty) {
                          final Map<String, dynamic> comment = {
                            'msg': chatController.text,
                            // 'image': downloadURL,
                            'userID': sl<UserCubit>().state.userEntity!.id,
                            'timestamp': Timestamp.now(),
                          };

                          db
                              .collection('challenge')
                              .doc(widget.args.docID)
                              .collection('comments')
                              .add(comment)
                              .then(
                            (_) {
                              chatController.clear();
                              FocusUtils(context).unfocus();
                            },
                          ).onError(
                            (error, _) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Maaf comment anda gagal: $error',
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
