import 'package:flutter/material.dart';
import 'package:oshifit/data/repositories/city_repositories.dart';
import 'package:oshifit/models/outfit.dart';
import 'package:oshifit/ui/widgets/weather_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ui/screens/location_screen.dart';

void main() {
  // runApp(const LocationScreen());
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: GoogleFonts.nunito().fontFamily,
      textTheme:  GoogleFonts.nunitoSansTextTheme()
    ),
    // home: const OutfitScreen()
    home: WeatherCard(city: City.PhnomPenh, weatherImage: 'assets/weather/cloudy.png', currentWeather: Weather.cloudy, currentTemp: 28, highTemp: 29, lowTemp: 23)
    )
  );
}