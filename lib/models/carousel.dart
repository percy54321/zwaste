import 'package:cloud_firestore/cloud_firestore.dart';

class CarouselImage {
  final String imageUrl;
  final String? id;
  final String? name;

  CarouselImage({this.name, this.id, required this.imageUrl});

  factory CarouselImage.fromFirestore(Map<String, dynamic> data, String id) {
    return CarouselImage(
      id: id,
      name:data['title'],
      imageUrl: data['image'] ?? '',
    );
  }
}
