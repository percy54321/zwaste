import 'package:cloud_firestore/cloud_firestore.dart';

class AvailableFoodImage {
  final String imageUrl;
  final String? id;
  final String? name;

  AvailableFoodImage({this.name, this.id, required this.imageUrl});

  factory AvailableFoodImage.fromFirestore(Map<String, dynamic> data, String id) {
    return AvailableFoodImage(
      id: id,
      name:data['name'],
      imageUrl: data['image'] ?? '',
    );
  }
}
