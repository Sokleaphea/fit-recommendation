import 'package:flutter/material.dart';
import '../../data/repositories/location_repository.dart';
import '../../models/location_model.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final repo = LocationRepository();

  LocationModel? _location;
  String? _error;
  bool _loading = false;

  Future<void> _checkLocation() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final loc = await repo.getLocation();
      setState(() {
        _location = loc;
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
      appBar: AppBar(title: Text('Check Location')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_loading) CircularProgressIndicator(),
            if (_location != null)
              Text(
                'Latitude: ${_location!.latitude}\nLongitude: ${_location!.longitude}',
                textAlign: TextAlign.center,
              ),
            if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkLocation,
              child: Text('Check Location'),
            ),
          ],
        ),
      ),
    );
  }
}
