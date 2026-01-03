import 'package:flutter/material.dart';
import '../widgets/outfit_card_details.dart';
import '../../data/mocks/outfits_data.dart';

class OutfitSreen extends StatelessWidget {
  const OutfitSreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: OutfitCardDetails(outfit: outfits[0]));
  }
}
