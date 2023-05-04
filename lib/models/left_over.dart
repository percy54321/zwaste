class LeftOver {
  final String imageUrl;
  final String? id;
  final String? name;

  LeftOver({this.name, this.id, required this.imageUrl});

  factory LeftOver.fromFirestore(Map<String, dynamic> data, String id) {
    return LeftOver(
      id: id,
      name:data['name'],
      imageUrl: data['image'] ?? '',
    );
  }
}
