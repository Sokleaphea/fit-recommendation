import 'package:oshifit/data/repositories/city_repositories.dart';
import 'package:oshifit/models/outfit.dart';
import 'package:oshifit/models/outfit_criteria.dart';

class OutfitFilterService {
  List<Outfit> filterOutfits(List<Outfit> outfits, OutfitCriteria criteria, City? currentCity) {
    final List<Styles> stylesToFilter = criteria.selectedStyles.length > 3 
      ? criteria.selectedStyles.sublist(0, 3) 
      : criteria.selectedStyles;

    List<Outfit> filtered = outfits.where(
      (outfit) => outfit.suitableWeather == criteria.selectedWeather
    ).toList();

    if (stylesToFilter.isNotEmpty) {
      filtered = filtered.where(
        (outfit) => stylesToFilter.contains(outfit.style)
      ).toList();
    }

    if (criteria.currentLocation && currentCity != null) {
      filtered = filtered.where(
        (outfit) => outfit.city == currentCity
      ).toList();
    }

    return filtered;
  }
}
