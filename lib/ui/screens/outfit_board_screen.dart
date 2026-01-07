import 'package:flutter/material.dart';
import 'package:oshifit/data/mocks/outfits_data.dart';
import 'package:oshifit/ui/screens/outfit_form.dart';
import 'package:oshifit/ui/screens/wizzard_screen.dart';
import 'package:oshifit/ui/widgets/outfit_grid.dart';
import 'package:oshifit/models/outfit.dart';

class OutfitBoardScreen extends StatefulWidget {
  const OutfitBoardScreen({super.key});

  @override
  State<OutfitBoardScreen> createState() => _OutfitBoardScreenState();
}

class _OutfitBoardScreenState extends State<OutfitBoardScreen> {
  late List<Outfit> _displayedOutfits;

  @override
  void initState() {
    super.initState();
    _displayedOutfits = outfits;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E6),
      appBar: AppBar(
        title: const Text(
          'Outfits Board',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFFFFF4E6),
        elevation: 0,
        centerTitle: false,
        titleSpacing: 12,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            icon: const Icon(Icons.try_sms_star_outlined, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WizzardScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () async {
              final newOutfit = await Navigator.push<Outfit>(
                context,
                MaterialPageRoute(builder: (context) => const OutfitForm()),
              );
              if (newOutfit != null) {
                setState(() {
                  _displayedOutfits.insert(0, newOutfit);
                });
              }
            },
          ),
        ],
      ),
      body: OutfitGrid(outfits: _displayedOutfits, scrollable: true),
    );
  }
}
