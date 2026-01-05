import 'package:oshifit/models/outfit.dart';
import 'package:oshifit/models/outfit_criteria.dart';
import 'package:oshifit/data/services/location_service.dart';
import 'package:oshifit/data/repositories/city_repositories.dart';

class OutfitFilterService {
  final _locationService = LocationService();
  final _cityRepo = CityRepositories();

  Future<List<Outfit>> filterOutfits(List<Outfit> source, OutfitCriteria criteria) async {
    var list = source.where((o) => o.suitableWeather == criteria.selectedWeather).toList();

    if (criteria.selectedStyles.isNotEmpty) {
      list = list.where((o) => criteria.selectedStyles.contains(o.style)).toList();
    }

    switch (criteria.locationMode) {
      case LocationMode.all:
        return list;
      case LocationMode.selected:
        if (criteria.selectedCity != null) {
          return list.where((o) => o.city == criteria.selectedCity).toList();
        }
        return [];
      case LocationMode.current:
        try {
          final pos = await _locationService.getCurrentLocation();
          final city = _cityRepo.matchCity(pos.latitude, pos.longitude);
          if (city != null) {
            return list.where((o) => o.city == city).toList();
          }
          return [];
        } catch (e) {
          return [];
        }
    }
  }
}
