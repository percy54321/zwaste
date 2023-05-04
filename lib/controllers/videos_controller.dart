import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


import '../models/video.dart';

class VideosController extends GetxController {
  final String courseId;
  final String topicId;

  VideosController({required this.courseId, required this.topicId});

  final RxList<Video> videos = RxList<Video>([]);

  @override
  void onInit() {
    super.onInit();
    videos.bindStream(getVideosStream(courseId, topicId));
  }

  Stream<List<Video>> getVideosStream(String courseId, String topicId) {
    final CollectionReference videosRef = FirebaseFirestore.instance
        .collection('courses')
        .doc(courseId)
        .collection('topics')
        .doc(topicId)
        .collection('videos');
  return videosRef.snapshots().map<List<Video>>((snapshot) {
  return snapshot.docs.map((doc) {
    return Video.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);  
  }).toList();
});



  }
}
