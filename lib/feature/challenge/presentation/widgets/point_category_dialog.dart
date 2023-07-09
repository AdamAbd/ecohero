import 'package:flutter/material.dart';

class PointCategoryDialog extends StatelessWidget {
  const PointCategoryDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 14,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Ketentuan Poin Tambahan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 6),
            AqiLevel(
              ctg: "Baik",
              poin: 0,
              color: Color(0xff93CC4B),
            ),
            AqiLevel(
              ctg: "Sedang",
              poin: 1,
              color: Color(0xffFFCF23),
            ),
            AqiLevel(
              ctg: "Tidak Sehat untuk Kelompok Sensitif",
              poin: 2,
              color: Color(0xffFEA120),
            ),
            AqiLevel(
              ctg: "Buruk",
              poin: 3,
              color: Color(0xffDC0703),
            ),
            AqiLevel(
              ctg: "Sangat Buruk",
              poin: 4,
              color: Color(0xff5B255F),
            ),
            AqiLevel(
              ctg: "Berbahaya",
              poin: 5,
              color: Color(0xff722221),
            ),
          ],
        ),
      ),
    );
  }
}

class AqiLevel extends StatelessWidget {
  const AqiLevel({
    Key? key,
    required this.ctg,
    required this.poin,
    required this.color,
  }) : super(key: key);

  final String ctg;
  final int poin;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            margin: const EdgeInsets.only(left: 14, top: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              "Level AQI: $ctg",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 1,
          child: Container(
            height: 54,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            margin: const EdgeInsets.only(right: 14, top: 4),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              "+$poin Poin",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
