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
        title: const Text('Filter Results', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: const Color(0xFFFFF4E6),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: const Color(0xFFFFF4E6),
      body: OutfitGrid(outfits: outfits),
    );
  }
}
