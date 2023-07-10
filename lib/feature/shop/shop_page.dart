import 'package:flutter/material.dart';

import 'package:ecohero/feature/feature.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Toko",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        childAspectRatio: 9 / 10,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: const [
          ShopItem(
            title: "Bibit Tanaman",
            price: 6000,
            image: AppIllustration.plantSeed,
          ),
          ShopItem(
            title: "Sayur Organik",
            price: 13000,
            image: AppIllustration.organicVegetable,
          ),
          ShopItem(
            title: "Donasi 100k",
            price: 100000,
            image: AppIllustration.donate,
          ),
          ShopItem(
            title: "Donasi 200k",
            price: 200000,
            image: AppIllustration.donate,
          ),
        ],
      ),
    );
  }
}

class ShopItem extends StatelessWidget {
  const ShopItem({
    Key? key,
    required this.title,
    required this.price,
    required this.image,
  }) : super(key: key);

  final String title;
  final int price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 10,
        ),
        decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              "$price Poin",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
