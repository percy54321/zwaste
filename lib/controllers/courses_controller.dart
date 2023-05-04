import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


import '../models/foods.dart';

class CoursesController extends GetxController {
  final CollectionReference coursesRef =
      FirebaseFirestore.instance.collection('options');

  final RxList<Course> courses = RxList<Course>([]);

  @override
  void onInit() {
    super.onInit();
    courses.bindStream(getCoursesStream());
  }

Stream<List<Course>> getCoursesStream() {
  return coursesRef.snapshots().map<List<Course>>((snapshot) {
    return snapshot.docs.map((doc) => Course.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)).toList();
  });
}


}


