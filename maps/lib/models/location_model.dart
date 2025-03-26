import 'package:latlong2/latlong.dart';

class LocationModel {
  final double latitude;
  final double longitude;
  final String title;
  final String description;

  LocationModel({
    required this.latitude,
    required this.longitude,
    this.title = '',
    this.description = '',
  });

  LatLng get coordinates => LatLng(latitude, longitude);
}
