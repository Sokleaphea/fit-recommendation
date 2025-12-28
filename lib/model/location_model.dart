class LocationModel {
  final double latitude;
  final double longitude;

  LocationModel({required this.latitude, required this.longitude});
  @override
  String toString() {
    return 'Latitude: $latitude, Longitude: $longitude';
  }
}