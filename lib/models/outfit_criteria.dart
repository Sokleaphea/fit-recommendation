import 'package:oshifit/models/outfit.dart';

class OutfitCriteria {
  Weather selectedWeather;
  List<Styles> selectedStyles = [];
  bool currentLocation = true;

  OutfitCriteria({required this.selectedWeather});
}
