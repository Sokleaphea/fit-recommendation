import 'package:oshifit/models/outfit.dart';
import '../mocks/outfits_data.dart';
import '../../models/city_model.dart';

class OutfitRecommendationService {
  final List<Outfit> _outfits = outfits;

  List<Outfit> recommendOutfitsForCity(City city) {
    return _outfits.where((o) => o.city == city).toList();
  }

  List<Outfit> recommendOutfitsForWeather(City city, Weather weather) {
    return _outfits
        .where((o) => o.city == city && o.suitableWeather == weather)
        .toList();
  }
}
