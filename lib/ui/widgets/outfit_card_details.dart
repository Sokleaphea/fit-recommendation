import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/outfit.dart';
import '../../models/city_model.dart';
import '../../models/favorite_model.dart';

class OutfitCardDetails extends StatefulWidget {
  final Outfit outfit;
  const OutfitCardDetails({super.key, required this.outfit});

  @override
  State<OutfitCardDetails> createState() => _OutfitCardDetailsState();
}

class _OutfitCardDetailsState extends State<OutfitCardDetails> {
  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoriteModel>();
    final isFavorite = favorites.isFavorite(widget.outfit);

    return Center(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth * 1;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    widget.outfit.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.outfit.description,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        favorites.toggleFavorite(widget.outfit);
                      },
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                        size: 30,
                        color: isFavorite ? Colors.red : const Color(0xFF456882),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "City: ${widget.outfit.city.displayName}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Shop Name: ${widget.outfit.shopName}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Price: \$${widget.outfit.price.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF456882),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        widget.outfit.style.name,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFF4E6),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
