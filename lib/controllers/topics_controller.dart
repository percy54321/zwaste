import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


import '../models/topic.dart';

class TopicController extends GetxController {
  final String courseId;
  final CollectionReference topicsRef;

  final RxList<Topic> topics = RxList<Topic>([]);

  TopicController({required this.courseId})
      : topicsRef = FirebaseFirestore.instance
            .collection('courses')
            .doc(courseId)
            .collection('topics');

  @override
  void onInit() {
    super.onInit();
    topics.bindStream(getTopicsStream());
  }

  Stream<List<Topic>> getTopicsStream() {
    return topicsRef.snapshots().map<List<Topic>>((snapshot) {
      return snapshot.docs
          .map((doc) => Topic.fromFirestore(doc.data() as Map<String, dynamic>,doc.id))
          .toList();
    });
  }
}
