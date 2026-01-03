import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:oshifit/ui/widgets/outfit_card.dart';
import '../../data/repositories/location_repository.dart';
import '../../models/location_model.dart';
import '../../models/outfit.dart';
import '../../models/city_model.dart';
import '../../data/repositories/city_repositories.dart';
import '../../data/services/outfit_recommendation_service.dart';
import '../../ui/widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Weather currentWeather = Weather.rainy;
  int currentTemp = 30;
  int highTemp = 32;
  int lowTemp = 28;
  String weatherImage = 'assets/weather/rainy.png';
  final locationRepo = LocationRepository();
  final cityRepo = CityRepositories();
  final outfitService = OutfitRecommendationService();

  LocationModel? _location;
  City? _city;
  List<Outfit> _outfits = [];
  String? _error;
  bool _loading = false;

  Future<void> _loadRecommendations() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final loc = await locationRepo.getLocation();
      setState(() {
        _location = loc;
        _city = cityRepo.matchCity(loc.latitude, loc.longitude);
        if (_city != null) {
          _outfits = outfitService.recommendOutfitsForCity(_city!);
          _outfits = outfitService.recommendOutfitsForWeather(
            _city!,
            currentWeather,
          );
        }
      });
      print(_location);
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E6),
      appBar: AppBar(
        title: Text(
          "Today's Weather",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        titleSpacing: 12,
        elevation: 0,
        backgroundColor: const Color(0xFFFFF4E6),
      ),
      body: SingleChildScrollView(
        child: _loading
            ? Center(child: CircularProgressIndicator())
            : _error != null
            ? Text(_error!, style: TextStyle(color: Colors.red))
            : _city == null
            ? Center(child: Text("Couldn't detect your city"))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16.0,
                    ),
                    child: WeatherCard(
                      city: _city!,
                      weatherImage: weatherImage,
                      currentWeather: currentWeather,
                      currentTemp: currentTemp,
                      highTemp: highTemp,
                      lowTemp: lowTemp,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Recommended Outfits",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: MasonryGridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _outfits.length,
                      itemBuilder: (context, index) {
                        final outfit = _outfits[index];
                        return OutfitCard(outfit: outfit);
                      },
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadRecommendations,
        backgroundColor: Color(0xFFFFF4E6),
        child: Icon(Icons.refresh, color: Color(0xFF456882)),
      ),
    );
  }
}
