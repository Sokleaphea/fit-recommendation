import 'package:flutter/material.dart';
import '../../data/repositories/location_repository.dart';
import '../../models/location_model.dart';
import '../../models/outfit.dart';
import '../../data/repositories/city_repositories.dart';
import '../../data/services/outfit_recommendation_service.dart';

class OutfitScreen extends StatefulWidget {
  const OutfitScreen({super.key});

  @override
  State<OutfitScreen> createState() => _OutfitScreenState();
}

class _OutfitScreenState extends State<OutfitScreen> {
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
      appBar: AppBar(title: Text('Outfit Recommendations')),
      body: Center(
        child: _loading
            ? CircularProgressIndicator()
            : _error != null
            ? Text(_error!, style: TextStyle(color: Colors.red))
            : _city == null
            ? Text('Could not detect your city')
            : Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Your city: ${_city!.displayName}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _outfits.length,
                      itemBuilder: (context, index) {
                        final outfit = _outfits[index];
                        return ListTile(
                          leading: Image.asset(outfit.imagePath),
                          title: Text(outfit.description),
                          subtitle: Text(
                            '${outfit.shopName} - \$${outfit.price}',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadRecommendations,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
