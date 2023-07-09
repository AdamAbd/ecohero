import 'package:flutter/material.dart';

import 'package:ecohero/feature/feature.dart';

class ChallengeCategoryDetailPageArgs {
  const ChallengeCategoryDetailPageArgs({required this.title});

  final String title;
}

class ChallengeCategoryDetailPage extends StatelessWidget {
  const ChallengeCategoryDetailPage({super.key, required this.args});

  final ChallengeCategoryDetailPageArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Penjelasan Challenge",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AppIllustration.mockImage,
              width: double.infinity,
              height: 260,
              fit: BoxFit.cover,
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "args.desc",
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
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
                    VerticalDivider(),
                    Column(
                      children: [
                        Text(
                          'Poin',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "args.point.toString()",
                          style: TextStyle(fontSize: 14),
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
    );
  }
}
