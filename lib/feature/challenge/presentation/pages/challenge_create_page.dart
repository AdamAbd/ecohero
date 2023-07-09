import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/feature/feature.dart';
import 'package:ecohero/locator.dart';

class ChallengeCreatePageArgs {
  const ChallengeCreatePageArgs({required this.challengeEntity});

  final ChallengeEntity challengeEntity;
}

class ChallengeCreatePage extends StatefulWidget {
  const ChallengeCreatePage({super.key, required this.args});

  final ChallengeCreatePageArgs args;

  @override
  State<ChallengeCreatePage> createState() => _ChallengeCreatePageState();
}

class _ChallengeCreatePageState extends State<ChallengeCreatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<TextFieldEntity> _textFieldList = TextFieldEntity.challenge;

  /// Firebase Instance
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    for (final i in _textFieldList) {
      i.textController = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (final i in _textFieldList) {
      i.textController.clear();
      i.textController.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<ChallengeImagePickerCubit>(),
        ),
        BlocProvider(
          create: (_) => sl<ChallengeDateTimeCubit>(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () => FocusUtils(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Ikuti Challenge',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomImage(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: CustomTextFormField(
                          textFieldEntity: _textFieldList[0],
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: CustomTextFormField(
                          textFieldEntity: _textFieldList[1],
                          textStyle: const TextStyle(fontSize: 14),
                          maxLines: 5,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          "POIN",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const ListTile(
                        leading: Icon(Icons.place, size: 28),
                        title: Text(
                          "Jakarta",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.star_rounded, size: 28),
                        title: Text(
                          "${widget.args.challengeEntity.poin} Poin + 0 Poin Tambahan",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => const PointCategoryDialog(),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          margin: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: const Color(0xff26B4A1).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Cek Ketentuan Poin Tambahan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationStyle: TextDecorationStyle.wavy,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      BlocBuilder<ChallengeImagePickerCubit,
                          ChallengeImagePickerState>(
                        builder: (context, challengeImagePickerState) {
                          return BlocBuilder<ChallengeDateTimeCubit,
                              DateTimeRange>(
                            builder: (context, challengeDateTimeState) {
                              return Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                child: FilledButton(
                                  onPressed: () async {
                                    FocusUtils(context).unfocus();

                                    if (challengeImagePickerState
                                        is ChallengeImagePickerInitial) {
                                      showDialog(
                                        context: context,
                                        builder: (_) => const AlertDialog(
                                          title: Text("Gambar Belum Dipilih"),
                                          content: Text(
                                              "Pilih gambar kompetisi anda sebelum mengirim !"),
                                        ),
                                      );
                                    }

                                    if (_formKey.currentState?.validate() ==
                                            true &&
                                        challengeImagePickerState
                                            is ChallengeImagePickerPicked) {
                                      final TaskSnapshot uploadTask =
                                          await FirebaseStorage.instance
                                              .ref()
                                              .child(
                                                  'challenge/${DateTime.now().toString()}')
                                              .putFile(challengeImagePickerState
                                                  .image);

                                      final String downloadURL =
                                          await uploadTask.ref.getDownloadURL();

                                      final Map<String, dynamic> challenge =
                                          <String, dynamic>{
                                        'title': _textFieldList[0]
                                            .textController
                                            .text
                                            .trim(),
                                        'desc': _textFieldList[1]
                                            .textController
                                            .text,
                                        'image': downloadURL,
                                        'point':
                                            widget.args.challengeEntity.poin,
                                        'date': <String, dynamic>{
                                          'start': challengeDateTimeState.start,
                                          'end': challengeDateTimeState.end,
                                        },
                                        'userID': sl<UserCubit>()
                                            .state
                                            .userEntity!
                                            .id,
                                        'timestamp': Timestamp.now(),
                                      };

                                      db
                                          .collection('challenge')
                                          .add(challenge)
                                          .then(
                                        (DocumentReference doc) {
                                          Navigator.popUntil(
                                            context,
                                            ModalRoute.withName(PagePath.home),
                                          );

                                          final snackBar = SnackBar(
                                            content: Text(
                                              'DocumentSnapshot added with ID: ${doc.id}',
                                            ),
                                          );

                                          // Find the ScaffoldMessenger in the widget tree
                                          // and use it to show a SnackBar.
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        },
                                      );
                                    }
                                  },
                                  child: const Text('KIRIM'),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 14),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
