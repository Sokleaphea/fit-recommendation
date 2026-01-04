import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/outfit_grid.dart';
import '../../models/favorite_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorite = context.watch<FavoriteModel>();
    final favoritesOutfits = favorite.favorite;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E6),
      appBar: AppBar(
        title: const Text("Favorites", style: TextStyle(fontWeight: FontWeight.w600)),
        centerTitle: false,
        elevation: 0,
        backgroundColor: const Color(0xFFFFF4E6),
      ),
      body: favoritesOutfits.isEmpty 
        ? Center(
          child: Text(
            "You haven't liked anything yet", 
            style: Theme.of(context).textTheme.bodyLarge)
          ) : OutfitGrid(outfits: favoritesOutfits
        ),
    );
  }
}
