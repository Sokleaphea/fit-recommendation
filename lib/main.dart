import 'package:flutter/material.dart';
import 'package:oshifit/data/mocks/outfits_data.dart';
import 'package:oshifit/models/outfit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oshifit/ui/screens/outfit_board_screen.dart';
import 'package:oshifit/ui/widgets/outfit_card.dart';
import 'ui/screens/location_screen.dart';

void main() {
  // runApp(const LocationScreen());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: GoogleFonts.nunito().fontFamily,
      textTheme:  GoogleFonts.nunitoSansTextTheme()
    ),
    // home: OutfitBoardScreen()
    home: OutfitScreen(),
    )
  );
}
