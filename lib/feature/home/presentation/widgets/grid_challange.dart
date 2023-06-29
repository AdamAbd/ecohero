import 'package:ecohero/feature/feature.dart';
import 'package:flutter/material.dart';

class GridChallange extends StatelessWidget {
  const GridChallange({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 5 / 6,
        ),
        itemCount: 8,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.pushNamed(
            context,
            PagePath.challengeDetail,
            arguments: ChallengeDetailPageArgs(index: index),
          ),
          child: Column(
            children: [
              Hero(
                tag: 'imageHeroTransition_$index',
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.lightGreen[200],
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage(AppIllustration.mockImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                '[Dummy] Kurangi polusi kendaraan dengan menggukan angkutan umum',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              const Row(
                children: [
                  Icon(Icons.money),
                  SizedBox(width: 2),
                  Text(
                    '5 | Diikuti 250+',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
