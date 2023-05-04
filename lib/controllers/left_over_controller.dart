import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../models/carousel.dart';
import '../models/left_over.dart';

class LeftOverController extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final RxList<LeftOver> images = RxList([]);

  @override
  void onInit() {
    super.onInit();
    loadImages();
  }

  Future<void> loadImages() async {
    final snapshot = await _db.collection('leftovers').get();
    final imagesList = snapshot.docs
        .map((doc) => LeftOver.fromFirestore(doc.data(),doc.id))
        .toList();
    images.value = imagesList;
  }
}

