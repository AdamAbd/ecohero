import 'package:flutter/material.dart';

import 'package:ecohero/feature/feature.dart';

class ChallengeCategoryDetailPageArgs {
  const ChallengeCategoryDetailPageArgs({required this.challengeEntity});

  final ChallengeEntity challengeEntity;
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                'Challenge Anti Polusi ${args.challengeEntity.title}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                args.challengeEntity.desc,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Column(
              children: List.generate(
                (args.challengeEntity.act).length,
                (index) => Padding(
                  padding: const EdgeInsets.only(left: 30, top: 2, right: 14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 7, right: 6),
                        child: CircleAvatar(
                          radius: 4,
                          backgroundColor: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width:
                            MediaQuery.of(context).size.width - 30 - 14 - 6 - 8,
                        child: Text(
                          args.challengeEntity.act[index],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text(
                'Poin',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: List.generate(
                4,
                (index) => ListTile(
                  leading: Image.asset(
                    "assets/icons/star_$index.png",
                    height: 30,
                    width: 30,
                  ),
                  title: Text("Level ${index + 1}"),
                  subtitle:
                      Text("Ikuti Challenge ini Sebanyak ${(index + 1) * 4}x"),
                  trailing: SizedBox(
                    width: 30,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${args.challengeEntity.poin * (index + 1)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text("Poin")
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 14),
              child: Text(
                'Aktivitas Terbaru',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 2),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
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
              onPressed: () => Navigator.pushNamed(
                context,
                PagePath.challengeCreate,
                arguments: ChallengeCreatePageArgs(
                  challengeEntity: args.challengeEntity,
                ),
              ),
              child: const Text(
                'Ikuti Challenge',
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
