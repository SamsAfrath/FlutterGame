import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './treasure_provider.dart';
import './treasure_map_screen.dart';

void main() {
  runApp(const TreasureHuntApp());
}

class TreasureHuntApp extends StatelessWidget {
  const TreasureHuntApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TreasureProvider(),
      child: MaterialApp(
        title: 'Treasure Hunt',
        theme: ThemeData(
          primarySwatch: Colors.amber,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const TreasureMapScreen(),
      ),
    );
  }
}