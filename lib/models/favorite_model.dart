import 'package:flutter/material.dart';
import '../models/outfit.dart';

class FavoriteModel extends ChangeNotifier {
  final List<Outfit> _favorites = [];
  List<Outfit> get favorite => _favorites;
  void toggleFavorite(Outfit outfit) {
    if (_favorites.contains(outfit)) {
      _favorites.remove(outfit);
    } else {
      _favorites.add(outfit);
    }
    notifyListeners();
  }

  bool isFavorite(Outfit outfit) {
    return _favorites.contains(outfit);
  }
}
