import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LatLng {
  const LatLng({required this.lat, required this.lng});

  factory LatLng.fromJson(Map<String, dynamic> json) {
    return LatLng(lat: json['lat'] as double, lng: json['lng'] as double);
  }

  Map<String, dynamic> toJson() => {'lat': lat, 'lng': lng};

  final double lat;
  final double lng;
}

@JsonSerializable()
class Region {
  Region({
    required this.coords,
    required this.id,
    required this.name,
    required this.zoom,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      coords: LatLng.fromJson(json['coords'] as Map<String, dynamic>),
      id: json['id'] as String,
      name: json['name'] as String,
      zoom: json['zoom'] as double,
    );
  }

  Map<String, dynamic> toJson() => {
    'coords': coords.toJson(),
    'id': id,
    'name': name,
    'zoom': zoom,
  };

  final LatLng coords;
  final String id;
  final String name;
  final double zoom;
}

@JsonSerializable()
class Office {
  Office({
    required this.address,
    required this.id,
    required this.image,
    required this.lat,
    required this.lng,
    required this.name,
    required this.phone,
    required this.region,
  });

  factory Office.fromJson(Map<String, dynamic> json) {
    return Office(
      address: json['address'] as String,
      id: json['id'] as String,
      image: json['image'] as String,
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      name: json['name'] as String,
      phone: json['phone'] as String,
      region: json['region'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'address': address,
    'id': id,
    'image': image,
    'lat': lat,
    'lng': lng,
    'name': name,
    'phone': phone,
    'region': region,
  };

  final String address;
  final String id;
  final String image;
  final double lat;
  final double lng;
  final String name;
  final String phone;
  final String region;
}

@JsonSerializable()
class Locations {
  Locations({required this.offices, required this.regions});
  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
      offices:
          (json['offices'] as List<dynamic>)
              .map((e) => Office.fromJson(e as Map<String, dynamic>))
              .toList(),
      regions:
          (json['regions'] as List<dynamic>)
              .map((e) => Region.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'offices': offices.map((e) => e.toJson()).toList(),
    'regions': regions.map((e) => e.toJson()).toList(),
  };

  final List<Office> offices;
  final List<Region> regions;
}

Future<Locations> getGoogleOffices() async {
  const googleLocationsURL = 'https://about.google/static/data/locations.json';

  // Retrieve the locations of Google offices
  try {
    final response = await http.get(Uri.parse(googleLocationsURL));
    if (response.statusCode == 200) {
      return Locations.fromJson(
        json.decode(response.body) as Map<String, dynamic>,
      );
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }

  return Locations.fromJson(
    json.decode(await rootBundle.loadString('assets/locations.json'))
        as Map<String, dynamic>,
  );
}
