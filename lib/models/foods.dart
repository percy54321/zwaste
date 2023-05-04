import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  final String name;
  final String imageUrl;
  final String description;
  final String? id;

  Course({
    this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });

factory Course.fromFirestore(Map<String, dynamic> data, String id) {
  return Course(
    id: id,
    name: data['name'] ?? '',
    imageUrl: data['image'] ?? '',
    description: data['description'] ?? '',
  );
}


}
