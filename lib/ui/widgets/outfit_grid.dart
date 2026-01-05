import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:oshifit/models/outfit.dart';
import 'package:oshifit/ui/widgets/outfit_card.dart';

class OutfitGrid extends StatelessWidget {
  final List<Outfit> outfits;
  final bool scrollable;

  const OutfitGrid({
    super.key,
    required this.outfits,
    this.scrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      shrinkWrap: !scrollable,
      physics: scrollable
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      primary: scrollable,
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
    );
  }
}