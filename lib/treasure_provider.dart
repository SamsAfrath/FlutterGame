import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './models/treasure.dart';

class TreasureProvider extends ChangeNotifier {
  List<Treasure> _treasures = [];
  
  List<Treasure> get treasures => _treasures;
  
  TreasureProvider() {
    _initializeTreasures();
  }

  void _initializeTreasures() {
    // Hard-coded treasure data
    _treasures = [
      Treasure(
        id: '1',
        name: 'Golden Oak',
        x: 0.18,
        y: 0.72,
        location: 'N 40.7589° W 73.9851°',
        description: 'Hidden near a large oak tree',
      ),
      Treasure(
        id: '2',
        name: 'River Rock Gem',
        x: 0.55,
        y: 0.60,
        location: 'N 40.7505° W 73.9934°',
        description: 'Under the big rock by the river',
      ),
      Treasure(
        id: '3',
        name: 'Market Square Coin',
        x: 0.40,
        y: 0.28,
        location: 'N 40.7614° W 73.9776°',
        description: 'Buried in the old market square',
      ),
      Treasure(
        id: '4',
        name: 'Lighthouse Pearl',
        x: 0.80,
        y: 0.20,
        location: 'N 40.7680° W 73.9641°',
        description: 'Inside a secret compartment',
      ),
      Treasure(
        id: '5',
        name: 'Hilltop Crown',
        x: 0.68,
        y: 0.10,
        location: 'N 40.7738° W 73.9702°',
        description: 'At the very top of the hill',
      ),
      Treasure(
        id: '6',
        name: 'Ancient Scroll',
        x: 0.25,
        y: 0.45,
        location: 'N 40.7552° W 73.9888°',
        description: 'Hidden in the ruins of an old library',
      ),
    ];
    
    _loadDiscoveredState();
  }

  Future<void> _loadDiscoveredState() async {
    final prefs = await SharedPreferences.getInstance();
    final discoveredJson = prefs.getString('discovered_treasures');
    
    if (discoveredJson != null) {
      final discoveredIds = List<String>.from(json.decode(discoveredJson));
      for (var treasure in _treasures) {
        treasure.isDiscovered = discoveredIds.contains(treasure.id);
      }
      notifyListeners();
    }
  }

  Future<void> toggleTreasureDiscovered(String treasureId) async {
    final treasureIndex = _treasures.indexWhere((t) => t.id == treasureId);
    if (treasureIndex != -1) {
      _treasures[treasureIndex].isDiscovered = !_treasures[treasureIndex].isDiscovered;
      await _saveDiscoveredState();
      notifyListeners();
    }
  }

  Future<void> _saveDiscoveredState() async {
    final prefs = await SharedPreferences.getInstance();
    final discoveredIds = _treasures
        .where((treasure) => treasure.isDiscovered)
        .map((treasure) => treasure.id)
        .toList();
    
    await prefs.setString('discovered_treasures', json.encode(discoveredIds));
  }

  int get discoveredCount => _treasures.where((t) => t.isDiscovered).length;
  int get totalCount => _treasures.length;
}