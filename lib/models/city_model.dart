enum City { PhnomPenh, SiemReap, Battambang, BanteayMeanchey, Takeo }

class CityLocaiton {
  final City city;
  final double latMin, latMax, lngMin, lngMax;
  CityLocaiton(
    this.city,
    this.latMin,
    this.latMax,
    this.lngMin,
    this.lngMax, {
    required,
  });
}

extension CityExtension on City {
  String get displayName {
    switch (this) {
      case City.PhnomPenh:
        return 'Phnom Penh';
      case City.SiemReap:
        return 'Siem Reap';
      case City.Battambang:
        return 'Battambang';
      case City.BanteayMeanchey:
        return 'Banteay Meanchey';
      case City.Takeo:
        return 'Takeo';
    }
  }
}