import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLayout extends StatelessWidget {
  const ShimmerLayout({super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.5),
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
