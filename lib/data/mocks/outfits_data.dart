import 'package:uuid/uuid.dart';
import '../../models/outfit.dart';
import '../../models/city_model.dart';

var uuid = Uuid();

List<Outfit> outfits = [
  Outfit(
    description: "Vintage Streetwear",
    city: City.PhnomPenh,
    shopName: "Sunshine Store",
    price: 15.0,
    suitableWeather: Weather.sunny,
    style: Styles.casual,
    imagePath: "assets/outfits/outfit-1.jpg",
    imagePath: "assets/outfits/3.jpg",
  ),
  Outfit(
    description: "Elegant evening dress for formal events",
    city: City.PhnomPenh,
    shopName: "Royal Boutique",
    price: 120.0,
    suitableWeather: Weather.sunny,
    style: Styles.streetwear,
    imagePath: "assets/outfits/outfit-2.jpg",
    imagePath: "assets/outfits/4.jpg",
  ),
  Outfit(
    description: "Warm hoodie for chilly mornings",
    city: City.Battambang,
    shopName: "Cozy Corner",
    price: 40.0,
    suitableWeather: Weather.cold,
    style: Styles.casual,
    imagePath: "assets/outfits/outfit-3.jpg",
    imagePath: "assets/outfits/3.jpg",
  ),
  Outfit(
    description: "Raincoat to stay dry in wet weather",
    city: City.BanteayMeanchey,
    shopName: "Rainy Day Shop",
    price: 35.0,
    suitableWeather: Weather.rainy,
    style: Styles.minimalist,
    imagePath: "assets/outfits/outfit-4.jpg",
    imagePath: "assets/outfits/4.jpg",
  ),
  Outfit(
    description: "Traditional Khmer outfit for ceremonies",
    city: City.Takeo,
    shopName: "Heritage Store",
    price: 60.0,
    suitableWeather: Weather.sunny,
    style: Styles.minimalist,
    imagePath: "assets/outfits/5.jpg",
  ),
];
