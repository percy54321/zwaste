import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  final String title;
  final String duration;
  final String url;
  final String? id;

  Video({
    this.id,
   required this.title,
   required this.duration,
   required this.url
  });

factory Video.fromFirestore(Map<String, dynamic> data, String id) {
  return Video(
    id: id,
    title: data['title'] ?? '',
    duration: data['duration'] ?? '',
    url: data['url'] ?? '',
  );
}


}
