import 'package:oshifit/models/city_model.dart';
import 'package:oshifit/models/outfit.dart';

enum LocationMode { all, current, selected }

class OutfitCriteria {
  Weather selectedWeather;
  List<Styles> selectedStyles = [];
  LocationMode locationMode = LocationMode.current;
  City? selectedCity;

  OutfitCriteria({required this.selectedWeather});
}
