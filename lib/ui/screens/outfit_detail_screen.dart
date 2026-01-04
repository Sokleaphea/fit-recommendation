import 'package:flutter/material.dart';
import 'package:oshifit/data/mocks/outfits_data.dart';
import 'package:oshifit/models/outfit.dart';
import 'package:oshifit/ui/widgets/outfit_card.dart';
import 'package:oshifit/ui/widgets/outfit_card_details.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class OutfitDetailScreen extends StatelessWidget {
  final Outfit outfit;
  const OutfitDetailScreen({super.key, required this.outfit});

  @override
  Widget build(BuildContext context) {
    final other = outfits.where((o) => o != outfit).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), 
          onPressed: () => Navigator.of(context).maybePop()
        ),
        title: const Text(
          'Back', 
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)
        ),
        centerTitle: false,
      ),
      backgroundColor: const Color(0xFFFFF4E6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutfitCardDetails(outfit: outfit),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'More outfits', 
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)
                  ),
                ),
                const SizedBox(height: 8),
                MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 14,
                  itemCount: other.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => OutfitCard(outfit: other[index]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
