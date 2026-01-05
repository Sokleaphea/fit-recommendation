import 'package:uuid/uuid.dart';
import '../models/city_model.dart';

var uuid = Uuid();

enum Weather {
  Cloudy('cloudy.png'),
  Cold('cold.png'),
  Rainy('raniny.png'),
  Sunny('sunny.png'),
  Windy('windy.png');

  final String imagePath;

  const Weather(this.imagePath);
}

enum Styles { Casual, Streetwear, Minimalist, Chic, Fit, Oversized }

class Outfit {
  final String id;
  final String description;
  final City city;
  final String shopName;
  final double price;
  Weather suitableWeather;
  Styles style;
  final String imagePath;

  Outfit({String? id, required this.description, required this.city, required this.shopName, required this.price, required this.suitableWeather, required this.style, required this.imagePath}) : id = id ?? uuid.v4();
}
