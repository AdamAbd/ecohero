import 'package:ecohero/feature/common/utils/assets.dart';
import 'package:flutter/material.dart';

class ChallengeCategoryPage extends StatelessWidget {
  const ChallengeCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Kategori Challenge",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        childAspectRatio: 8 / 7,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          ChallengeCategoryItem(
            title: "Transportasi",
            image: AppIllustration.car,
            onTap: () {},
          ),
          ChallengeCategoryItem(
            title: "Asap Pabrik",
            image: AppIllustration.factory,
            onTap: () {},
          ),
          ChallengeCategoryItem(
            title: "Listrik Rumah",
            image: AppIllustration.tableLamp,
            onTap: () {},
          ),
          ChallengeCategoryItem(
            title: "Asap Hasil Pembakaran",
            image: AppIllustration.burning,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ChallengeCategoryItem extends StatelessWidget {
  const ChallengeCategoryItem({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  final String title;
  final String image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(image),
                alignment: Alignment.bottomRight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
