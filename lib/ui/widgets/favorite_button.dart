import 'package:flutter/material.dart';
import '../../models/outfit.dart';
import '../../models/favorite_model.dart';
import 'package:provider/provider.dart';

class FavoriteButton extends StatelessWidget {
  final Outfit outfit;
  const FavoriteButton({super.key, required this.outfit});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteModel>(
      builder: (context, favs, _) {
        final isLiked = favs.isFavorite(outfit);
        return IconButton(
          onPressed: () {
            favs.toggleFavorite(outfit);
          },
          icon: Icon(
            isLiked ? Icons.favorite : Icons.favorite_border_outlined,
            color: isLiked ? Colors.red : Colors.black,
          ),
        );
      },
    );
  }
}
