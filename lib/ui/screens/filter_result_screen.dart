import 'package:flutter/material.dart';
import 'package:oshifit/models/outfit.dart';
import 'package:oshifit/ui/widgets/outfit_grid.dart';

class FilterResultScreen extends StatelessWidget {
  final List<Outfit> outfits;
  const FilterResultScreen({super.key, required this.outfits});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF4E6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios), 
          onPressed: () => Navigator.of(context).maybePop()
        ),
        title: const Text(
          'Result', 
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)
        ),
        centerTitle: false,
      ),
      backgroundColor: const Color(0xFFFFF4E6),
      body: OutfitGrid(outfits: outfits),
    );
  }
}
