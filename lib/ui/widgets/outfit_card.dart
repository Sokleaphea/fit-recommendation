import 'package:flutter/material.dart';
import 'package:oshifit/models/outfit.dart';
import 'package:provider/provider.dart';
import '../../models/favorite_model.dart';

class OutfitCard extends StatefulWidget {
  final Outfit outfit;
  const OutfitCard({super.key, required this.outfit});

  @override
  State<OutfitCard> createState() => _OutfitCardState();
}

class _OutfitCardState extends State<OutfitCard> {
  // final favorites = context.watch<FavoriteModel>();
  // final isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoriteModel>();
    final isFavorite = favorites.isFavorite(widget.outfit);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            widget.outfit.imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // setState(() => isFavorite = !isFavorite);
              favorites.toggleFavorite(widget.outfit);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 4), // optional, reduce/remove
              child: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.black,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
