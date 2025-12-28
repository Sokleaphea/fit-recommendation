import '../services/location_service.dart';
import '../../model/location_model.dart';

class LocationRepository {
  final _service = LocationService();
  Future<LocationModel> getLocation() async {
    final pos = await _service.getCurrentLocation();
    return LocationModel(latitude: pos.latitude, longitude: pos.longitude);
  }
}
