import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import '../view_models/map_view_model.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchController = TextEditingController();

    return Consumer<MapViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Google Maps Clone'),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.clear_all),
                onPressed: viewModel.clearMarkers,
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        decoration: const InputDecoration(
                          hintText: 'Konum ara (örn. İstanbul)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        final place = _searchController.text.trim();
                        if (place.isNotEmpty) {
                          viewModel.searchAndAddMarker(place);
                          _searchController.clear();
                        }
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FlutterMap(
                  options: MapOptions(
                    center: viewModel.currentLocation.coordinates,
                    zoom: viewModel.zoom,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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
              ),
            ],
          ),
        );
      },
    );
  }
}
