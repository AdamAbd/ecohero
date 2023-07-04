import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecohero/feature/feature.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChallengeImagePickerCubit, ChallengeImagePickerState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              height: 260,
              color: Colors.black12,
              child: (state is ChallengeImagePickerPicked)
                  ? Image.file(
                      state.image,
                      width: double.infinity,
                      height: 260,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.image_not_supported,
                      size: 48,
                    ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: FilledButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) {
                    return BlocProvider.value(
                      value: context.read<ChallengeImagePickerCubit>(),
                      child: ChallengePickImageDialog(),
                    );
                  },
                ),
                child: const Text('Ambil Gambar'),
              ),
            ),
          ],
        );
      },
    );
  }
}
