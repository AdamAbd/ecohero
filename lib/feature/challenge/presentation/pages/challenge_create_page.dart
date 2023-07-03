import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohero/feature/feature.dart';
import 'package:ecohero/locator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ChallengeCreatePage extends StatefulWidget {
  const ChallengeCreatePage({super.key});

  @override
  State<ChallengeCreatePage> createState() => _ChallengeCreatePageState();
}

class _ChallengeCreatePageState extends State<ChallengeCreatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<TextFieldEntity> _textFieldList = TextFieldEntity.challenge;

  /// Firebase Instance
  FirebaseFirestore db = FirebaseFirestore.instance;

  /// Point Value
  double pointValue = 1;

  /// Image
  final ImagePicker picker = ImagePicker();
  List<File> images = <File>[];

  Future<void> pickImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ambil Gambar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Row(
                    children: [
                      Icon(Icons.image),
                      SizedBox(width: 4),
                      Text('Dari Galeri'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImageFromGallery();
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Row(
                    children: [
                      Icon(Icons.photo_camera),
                      SizedBox(width: 4),
                      Text('Dari Kamera'),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImageFromCamera();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getImageFromGallery() async {
    final List<XFile> pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      setState(() {
        images.addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));
      });
    }
  }

  Future<void> getImageFromCamera() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1280,
      maxHeight: 720,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
      });
    }
  }

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
    return BlocProvider(
      create: (_) => sl<ChallengeDateTimeCubit>(),
      child: Builder(builder: (context) {
        return GestureDetector(
          onTap: () => FocusUtils(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(title: const Text('Buat Kompetisi')),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    images.isNotEmpty
                        ? Image.file(
                            File(images[0].path),
                            width: double.infinity,
                            height: 260,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: double.infinity,
                            height: 260,
                            color: Colors.black12,
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 48,
                            ),
                          ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: FilledButton(
                        onPressed: pickImage,
                        child: const Text('Ambil Gambar'),
                      ),
                    ),
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
                        "PERATURAN",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const ListTile(
                      leading: Icon(Icons.timeline, size: 28),
                      title: Text(
                        "Berulang Setiap Hari",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const DateTimeListTile(),
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
                    Slider(
                      value: pointValue,
                      min: 1,
                      max: 10,
                      onChanged: (newValue) {
                        setState(() {
                          pointValue = newValue;
                        });
                      },
                      divisions: 9,
                      label: "${pointValue.toInt()} Poin",
                    ),
                    const SizedBox(height: 12),
                    BlocBuilder<ChallengeDateTimeCubit, DateTimeRange>(
                      builder: (context, state) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: FilledButton(
                            onPressed: () async {
                              FocusUtils(context).unfocus();

                              if (_formKey.currentState?.validate() == true) {
                                print("images");
                                print(images);

                                final List<TaskSnapshot> uploadTasks =
                                    await Future.wait(images.map((File image) =>
                                        FirebaseStorage.instance
                                            .ref()
                                            .child(
                                                'challenge/${DateTime.now().toString()}')
                                            .putFile(image)));

                                final List<String> downloadURLs =
                                    await Future.wait(
                                  uploadTasks.map(
                                    (TaskSnapshot uploadTask) =>
                                        uploadTask.ref.getDownloadURL(),
                                  ),
                                );

                                final Map<String, dynamic> image =
                                    <String, dynamic>{
                                  'title': _textFieldList[0]
                                      .textController
                                      .text
                                      .trim(),
                                  'desc': _textFieldList[1].textController.text,
                                  'images': downloadURLs,
                                  'point': pointValue.toInt(),
                                  'date': <String, dynamic>{
                                    'start': state.start,
                                    'end': state.end,
                                  },
                                  'userID':
                                      sl<UserCubit>().state.userEntity!.id,
                                  'timestamp': Timestamp.now(),
                                };

                                db
                                    .collection('challenge')
                                    .add(image)
                                    .then((DocumentReference doc) {
                                  Navigator.pop(context);

                                  final snackBar = SnackBar(
                                    content: Text(
                                      'DocumentSnapshot added with ID: ${doc.id}',
                                    ),
                                  );

                                  // Find the ScaffoldMessenger in the widget tree
                                  // and use it to show a SnackBar.
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                });
                              }
                            },
                            child: const Text('KIRIM'),
                          ),
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
      }),
    );
  }
}
