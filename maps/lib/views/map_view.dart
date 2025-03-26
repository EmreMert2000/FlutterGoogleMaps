import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../view_models/map_view_model.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MapViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('OpenStreetMap Demo'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add_location),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.clear_all),
                onPressed: viewModel.clearMarkers,
              ),
            ],
          ),
          body: FlutterMap(
            options: MapOptions(
              center: viewModel.currentLocation.coordinates,
              zoom: viewModel.zoom,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.maps',
              ),
              MarkerLayer(
                markers:
                    viewModel.markers.map((location) {
                      return Marker(
                        point: location.coordinates,
                        width: 80,
                        height: 80,
                        child: const Icon(
                          Icons.location_pin,
                          color: Colors.red,
                          size: 40,
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
