class Treasure {
  final String id;
  final String name;
  final double x; // Relative position (0.0 to 1.0)
  final double y; // Relative position (0.0 to 1.0)
  final String location;
  final String description;
  bool isDiscovered;

  Treasure({
    required this.id,
    required this.name,
    required this.x,
    required this.y,
    required this.location,
    required this.description,
    this.isDiscovered = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'x': x,
      'y': y,
      'location': location,
      'description': description,
      'isDiscovered': isDiscovered,
    };
  }

  factory Treasure.fromJson(Map<String, dynamic> json) {
    return Treasure(
      id: json['id'],
      name: json['name'],
      x: json['x'],
      y: json['y'],
      location: json['location'],
      description: json['description'],
      isDiscovered: json['isDiscovered'] ?? false,
    );
  }
}