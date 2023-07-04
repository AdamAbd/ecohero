import 'package:flutter/material.dart';

class ChallengeDetailPageArgs {
  const ChallengeDetailPageArgs({
    required this.title,
    required this.desc,
    required this.image,
    required this.point,
    required this.index,
  });

  final String title;
  final String desc;
  final String image;
  final int point;
  final int index;
}

class ChallengeDetailPage extends StatelessWidget {
  const ChallengeDetailPage({required this.args, super.key});

  final ChallengeDetailPageArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title, style: const TextStyle(fontSize: 16)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'imageHeroTransition_${args.index}',
              child: Image.network(
                args.image,
                width: double.infinity,
                height: 260,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.only(left: 24),
              child: Text(
                'Deskripsi Challange',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                args.desc,
                style: const TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Column(
                      children: [
                        Text(
                          'Waktu',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '9 - 10 am',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const VerticalDivider(),
                    Column(
                      children: [
                        const Text(
                          'Poin',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          args.point.toString(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 24),
              child: Text(
                'Aktivitas Terbaru',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 2),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                '[Dummy] Tantangan ini bertujuan untuk mengurangi jumlah kendaraan pribadi di jalan yang menyebabkan kemacetan dan polusi udara. Anda dapat beralih ke bus, kereta, atau Transjakarta untuk pergi ke tempat kerja atau tempat lain yang Anda tuju. Anda akan mendapatkan manfaat hemat waktu dan biaya dari tantangan ini. Jangan lupa untuk membagikan rute dan jadwal Anda di media sosial dengan tagar #BeralihKeBusKeretaAtauTransjakarta.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        shape: const Border(top: BorderSide.none),
        onClosing: () {},
        builder: (context) {
          return Container(
            margin: const EdgeInsets.all(16),
            height: 48,
            width: double.infinity,
            child: FilledButton(
              onPressed: () {},
              child: const Text(
                'Ikuti Tantangan',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
