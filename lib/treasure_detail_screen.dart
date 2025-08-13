import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './treasure_provider.dart';

class TreasureDetailDialog extends StatelessWidget {
  final treasure;

  const TreasureDetailDialog({
    super.key,
    required this.treasure,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  treasure.isDiscovered ? Icons.check_circle : Icons.star,
                  color: treasure.isDiscovered ? Colors.green : Colors.amber,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    treasure.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red, size: 20),
                const SizedBox(width: 8),
                Text(
                  treasure.location,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              treasure.description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Consumer<TreasureProvider>(
              builder: (context, provider, child) {
                return Row(
                  children: [
                    Checkbox(
                      value: treasure.isDiscovered,
                      onChanged: (value) {
                        provider.toggleTreasureDiscovered(treasure.id);
                      },
                      activeColor: Colors.green,
                    ),
                    const Text('Discovered'),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Close'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}