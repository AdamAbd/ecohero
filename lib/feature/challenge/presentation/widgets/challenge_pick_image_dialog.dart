import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ecohero/feature/feature.dart';

class ChallengePickImageDialog extends StatelessWidget {
  const ChallengePickImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
                context
                    .read<ChallengeImagePickerCubit>()
                    .pickImageFrom(ImageSource.gallery);
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
                context
                    .read<ChallengeImagePickerCubit>()
                    .pickImageFrom(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}
