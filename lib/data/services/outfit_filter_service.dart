import 'package:oshifit/models/city_model.dart';
import 'package:oshifit/models/outfit.dart';
import 'package:oshifit/models/outfit_criteria.dart';
import 'package:oshifit/data/services/location_service.dart';
import 'package:oshifit/data/repositories/city_repositories.dart';

class OutfitFilterService {
  Future<List<Outfit>> filterOutfits(List<Outfit> outfits, OutfitCriteria criteria, {City? currentCity, LocationService? locationService}) async {
    var filtered = outfits.where((o) => o.suitableWeather == criteria.selectedWeather).toList();

    if (criteria.selectedStyles.isNotEmpty) {
      filtered = filtered.where((o) => criteria.selectedStyles.contains(o.style)).toList();
    }

    switch (criteria.locationMode) {
      case LocationMode.all:
        return filtered;
      case LocationMode.current:
        if (currentCity != null) return filtered.where((o) => o.city == currentCity).toList();
        if (locationService == null) return <Outfit>[];
        try {
          final pos = await locationService.getCurrentLocation();
          final matched = CityRepositories().matchCity(pos.latitude, pos.longitude);
          if (matched == null) return <Outfit>[];
          return filtered.where((o) => o.city == matched).toList();
        } catch (_) {
          return <Outfit>[];
        }
      case LocationMode.selected:
        if (criteria.selectedCity == null) return <Outfit>[];
        return filtered.where((o) => o.city == criteria.selectedCity).toList();
    }
  }
}
