class Topic {
  final String name;
  final String? id;

  Topic({required this.name, this.id});

  factory Topic.fromFirestore(Map<String, dynamic> data, String id) {
    return Topic(
      id: id,
      name: data['name'] ?? '',
    
    );
  }
}
