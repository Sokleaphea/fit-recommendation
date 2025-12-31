import 'package:oshifit/data/repositories/city_repositories.dart';
import 'package:oshifit/models/outfit.dart';
import 'package:oshifit/models/outfit_criteria.dart';

class OutfitFilterService {
  List<Outfit> filterOutfits(List<Outfit> outfits, OutfitCriteria criteria, City? currentCity) {
    List<Outfit> filtered = outfits.where(
      (outfit) => outfit.suitableWeather == criteria.selectedWeather
    ).toList();

    if (criteria.selectedStyles.isNotEmpty) {
      filtered = filtered.where(
        (outfit) => criteria.selectedStyles.contains(outfit.style)
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
