import 'package:flutter/material.dart';
import 'package:oshifit/models/city_model.dart';
import 'package:oshifit/models/outfit.dart';

class WeatherCard extends StatelessWidget {
  final City city;
  final String weatherImage;
  final Weather currentWeather;
  final int currentTemp;
  final int highTemp;
  final int lowTemp;

  const WeatherCard({super.key, required this.city, required this.weatherImage,required this.currentWeather, required this.currentTemp, required this.highTemp, required this.lowTemp});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color.fromRGBO(128, 160, 174, 0.9), const Color.fromRGBO(69, 104, 130, 1.0)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: ListTile(
              leading: Image(image: AssetImage(weatherImage), width: 80, height: 80),
              title: Text(
                city.name,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(currentWeather.label, style: TextStyle(color: Colors.white)),
                  Text('H:$highTemp° L:$lowTemp°', style: TextStyle(color: Colors.white)),
                ],
              ),
              trailing: Text(
                '$currentTemp°',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
