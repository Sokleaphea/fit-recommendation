import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:oshifit/ui/widgets/outfit_card.dart';
import 'package:oshifit/data/mocks/outfits_data.dart';

class OutfitBoardScreen extends StatelessWidget {
  const OutfitBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E6),
      appBar: AppBar(
        title: const Text('Outfits Board', style: TextStyle(fontWeight: FontWeight.w600)), 
        backgroundColor: const Color(0xFFFFF4E6), 
        elevation: 0
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            sliver: SliverMasonryGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 14,
              childCount: outfits.length,
              itemBuilder: (context, index) {
                return OutfitCard(outfit: outfits[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
