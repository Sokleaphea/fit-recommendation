import '../../models/city_model.dart';

final _cities = [
  CityLocaiton(City.PhnomPenh, 11.4900, 11.6300, 104.8800, 105.0500),
  CityLocaiton(City.SiemReap, 13.3400, 13.4100, 103.8200, 103.9000),
  CityLocaiton(City.Battambang, 13.0700, 13.1700, 103.1900, 103.3000),
  CityLocaiton(City.BanteayMeanchey, 13.5200, 14.0300, 102.8500, 103.4300),
  CityLocaiton(City.Takeo, 10.9000, 11.2500, 104.3500, 104.7500),
];

class CityRepositories {
  City? matchCity(double lat, double lng) {
    for (var city in _cities) {
      if (lat >= city.latMin &&
          lat <= city.latMax &&
          lng >= city.lngMin &&
          lng <= city.lngMax) {
        return city.city;
      }
    }
    return null;
  }
}
