import 'package:flutter/material.dart';
import 'package:oshifit/data/mocks/outfits_data.dart';
import 'package:oshifit/models/outfit.dart';
import 'package:oshifit/ui/widgets/outfit_card_details.dart';
import 'package:oshifit/ui/widgets/outfit_grid.dart';

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    OutfitCardDetails(outfit: outfit),
                    const SizedBox(height: 20),
                    const Text(
                      'More outfits',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
              OutfitGrid(outfits: other, scrollable: false,),
            ],
          ),
        ),
      ),
    );
  }
}
