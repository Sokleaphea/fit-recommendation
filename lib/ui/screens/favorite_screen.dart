import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import '../widgets/outfit_card.dart';
import '../../models/favorite_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorite = context.watch<FavoriteModel>();
    final favoritesOutfits = favorite.favorite;
    if (favoritesOutfits.isEmpty) {
      return Center(child: Text("You haven't liked anything yet"));
    }
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E6),
      appBar: AppBar(title: Text("Favorites", style: TextStyle(fontWeight: FontWeight.w600)), centerTitle: false, elevation: 0, backgroundColor: const Color(0xFFFFF4E6)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 16.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12), 
                child: MasonryGridView.count(
                  crossAxisCount: 2, 
                  mainAxisSpacing: 16, 
                  crossAxisSpacing: 16, 
                  shrinkWrap: true, 
                  itemCount: favoritesOutfits.length,
                  itemBuilder: (context, index) {
                    final outfit = favoritesOutfits[index];
                    return OutfitCard(outfit: outfit);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
