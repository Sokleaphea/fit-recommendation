import 'package:uuid/uuid.dart';
import '../models/city_model.dart';

var uuid = Uuid();

enum Weather {
  cloudy('Cloudy', 'cloudy.png'),
  cold('Cold', 'cold.png'),
  rainy('Rainy', 'raniny.png'),
  sunny('Sunny', 'sunny.png'),
  windy('Windy', 'windy.png');

  final String label;
  final String imagePath;

  const Weather(this.label, this.imagePath);
}

enum Styles { casual, streetwear, vintage, minimalist, chic, fit, oversized }

class Outfit {
  final String id;
  final String description;
  final City city;
  final String shopName;
  final double price;
  Weather suitableWeather;
  Styles style;
  final String imagePath;

  Outfit({String? id, required this.description, required this.city, required this.shopName, required this.price, required this.suitableWeather, required this.style, required this.imagePath}) : id = uuid.v4();
}
