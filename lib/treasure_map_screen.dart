import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './treasure_provider.dart';
import './treasure_detail_screen.dart';

class TreasureMapScreen extends StatelessWidget {
  const TreasureMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Treasure Hunt'),
        backgroundColor: Colors.amber,
        elevation: 2,
        actions: [
          Consumer<TreasureProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    '${provider.discoveredCount}/${provider.totalCount}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: const TreasureMap(),
    );
  }
}

class TreasureMap extends StatelessWidget {
  const TreasureMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TreasureProvider>(
      builder: (context, provider, child) {
        return InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Stack(
                  children: [
                    // Background Map Image - NEW VERSION!
                    Positioned.fill(
                      child: Image.asset(
                        'assets/map.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback to gradient if image not found
                          return Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF87CEEB), // Sky blue
                                  Color(0xFF98FB98), // Pale green
                                  Color(0xFFDEB887), // Burlywood
                                ],
                                stops: [0.0, 0.4, 1.0],
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                '🗺️ Add map.png to assets folder\nfor custom treasure map!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Treasure Markers
                    ...provider.treasures.map((treasure) {
                      final x = treasure.x * constraints.maxWidth;
                      final y = treasure.y * constraints.maxHeight;
                      
                      return Positioned(
                        left: x - 20,
                        top: y - 20,
                        child: GestureDetector(
                          onTap: () => _showTreasureDetail(context, treasure),
                          child: TreasureMarker(
                            treasure: treasure,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  void _showTreasureDetail(BuildContext context, treasure) {
    showDialog(
      context: context,
      builder: (context) => TreasureDetailDialog(treasure: treasure),
    );
  }
}

class TreasureMarker extends StatelessWidget {
  final treasure;

  const TreasureMarker({
    super.key,
    required this.treasure,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: treasure.isDiscovered ? Colors.green : Colors.amber,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        treasure.isDiscovered ? Icons.check : Icons.star,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}