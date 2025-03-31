import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'view_models/map_view_model.dart';
import 'views/map_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MapViewModel(),
      child: MaterialApp(
        title: 'OpenStreetMap ',
        theme: ThemeData(
          
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const MapView(),
      ),
    );
  }
}
