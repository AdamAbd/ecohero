import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecohero/feature/feature.dart';
import 'package:ecohero/locator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChallengeCreatePage extends StatefulWidget {
  const ChallengeCreatePage({super.key});

  @override
  State<ChallengeCreatePage> createState() => _ChallengeCreatePageState();
}

class _ChallengeCreatePageState extends State<ChallengeCreatePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<TextFieldEntity> _textFieldList = TextFieldEntity.challenge;

  FirebaseFirestore db = FirebaseFirestore.instance;

  final ImagePicker picker = ImagePicker();
  List<File> images = <File>[];

  double pointValue = 0;

  Future<void> pickImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick Image'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text('From Gallery'),
                  onTap: () {
                    Navigator.of(context).pop();
                    getImageFromGallery();
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text('From Camera'),
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
    return GestureDetector(
      onTap: () => FocusUtils(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Challenge'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: pickImage,
                    child: const Text('Pick Image'),
                  ),
                  const SizedBox(height: 12),
                  if (images.isNotEmpty)
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image.file(
                          File(images[0].path),
                          width: double.infinity,
                          height: 260,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          width: 28,
                          height: 28,
                          margin: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "1/${images.length}",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: images.isNotEmpty ? 14 : 0),
                  SizedBox(
                    height: 70,
                    child: ListView.separated(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 12),
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            left: index == 0 ? 24 : 0,
                            right: index == images.length - 1 ? 24 : 0,
                          ),
                          child: Container(
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: FileImage(
                                  File(images[index].path),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextFormField(textFieldEntity: _textFieldList[0]),
                  CustomTextFormField(
                    textFieldEntity: _textFieldList[1],
                    maxLines: 5,
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
                    divisions: 10,
                    label: "${pointValue.toInt()} Poin",
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      FocusUtils(context).unfocus();

                      if (_formKey.currentState?.validate() == true) {
                        print("images");
                        print(images);

                        final List<TaskSnapshot> uploadTasks = await Future
                            .wait(images.map((File image) => FirebaseStorage
                                .instance
                                .ref()
                                .child('images/${DateTime.now().toString()}')
                                .putFile(image)));

                        final List<String> downloadURLs = await Future.wait(
                            uploadTasks.map((TaskSnapshot uploadTask) =>
                                uploadTask.ref.getDownloadURL()));

                        final Map<String, dynamic> image = <String, dynamic>{
                          'title': _textFieldList[0].textController.text.trim(),
                          'desc': _textFieldList[1].textController.text,
                          'image': downloadURLs,
                          'poin': pointValue.toInt(),
                          'userID': sl<UserCubit>().state.userEntity!.id,
                          'timestamp': Timestamp.now(),
                        };

                        db.collection('imageGenerator').add(image).then(
                              (DocumentReference doc) => print(
                                  'DocumentSnapshot added with ID: ${doc.id}'),
                            );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
