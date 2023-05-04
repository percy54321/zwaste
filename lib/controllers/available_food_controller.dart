import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


import '../models/avaialble_food.dart';
import '../models/foods.dart';

class AvailableFoodsController extends GetxController {
  final CollectionReference afoodRef =
      FirebaseFirestore.instance.collection('available_foods');

  final RxList<AvailableFoodImage > afoods = RxList<AvailableFoodImage >([]);

  @override
  void onInit() {
    super.onInit();
    afoods.bindStream(getAvailableFoodStream());
  }

Stream<List<AvailableFoodImage>> getAvailableFoodStream() {
  return afoodRef.snapshots().map<List<AvailableFoodImage>>((snapshot) {
    return snapshot.docs.map((doc) => AvailableFoodImage.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)).toList();
  });
}


}


