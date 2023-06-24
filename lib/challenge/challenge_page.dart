import 'package:flutter/material.dart';

class ChallengePage extends StatelessWidget {
  const ChallengePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Kurangi polusi kendaraan dengan menggukan angkutan umum",
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                  height: 260,
                  color: Colors.amberAccent,
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
                  child: const Text(
                    "1/4",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 70,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => const SizedBox(width: 12),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 24 : 0,
                      right: index == 5 ? 24 : 0,
                    ),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                },
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Tantangan ini bertujuan untuk mengurangi jumlah kendaraan pribadi di jalan yang menyebabkan kemacetan dan polusi udara. Anda dapat beralih ke bus, kereta, atau Transjakarta untuk pergi ke tempat kerja atau tempat lain yang Anda tuju. Anda akan mendapatkan manfaat hemat waktu dan biaya dari tantangan ini. Jangan lupa untuk membagikan rute dan jadwal Anda di media sosial dengan tagar #BeralihKeBusKeretaAtauTransjakarta.',
                style: TextStyle(fontSize: 14),
              ),
            ),
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Divider(),
            ),
            const SizedBox(height: 2),
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
                          'Jumlah',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '15 Peserta',
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
                          '100',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
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
            decoration: const BoxDecoration(color: Colors.amber),
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
