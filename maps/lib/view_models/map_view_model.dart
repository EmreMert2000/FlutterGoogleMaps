import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../models/location_model.dart';
import '../services/geocoding_service.dart';

class MapViewModel extends ChangeNotifier {
  LocationModel _currentLocation;
  List<LocationModel> _markers = [];
  double _zoom = 13.0;

  final GeocodingService _geoService = GeocodingService();

  MapViewModel()
    : _currentLocation = LocationModel(
        latitude: 41.0082,
        longitude: 28.9784,
        title: 'İstanbul',
        description: 'Türkiye\'nin en kalabalık şehri',
      ) {
    _markers.add(_currentLocation);
  }

  LocationModel get currentLocation => _currentLocation;
  List<LocationModel> get markers => _markers;
  double get zoom => _zoom;

  void updateLocation(LocationModel newLocation) {
    _currentLocation = newLocation;
    _markers = [_currentLocation];
    notifyListeners();
  }

  void updateZoom(double newZoom) {
    _zoom = newZoom;
    notifyListeners();
  }

  void addMarker(LocationModel marker) {
    _markers.add(marker);
    notifyListeners();
  }

  void clearMarkers() {
    _markers = [_currentLocation];
    notifyListeners();
  }

  Future<void> searchAndAddMarker(String placeName) async {
    final LatLng? result = await _geoService.getCoordinatesFromPlace(placeName);
    if (result != null) {
      addMarker(
        LocationModel(
          title: placeName,
          latitude: result.latitude,
          longitude: result.longitude,
        ),
      );
      _currentLocation = LocationModel(
        latitude: result.latitude,
        longitude: result.longitude,
        title: placeName,
        description: '',
      );
      notifyListeners();
    }
  }
}
