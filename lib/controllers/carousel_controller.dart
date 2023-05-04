import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../models/carousel.dart';

class CarouselControllerT extends GetxController {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final RxList<CarouselImage> images = RxList([]);

  @override
  void onInit() {
    super.onInit();
    loadImages();
  }

  Future<void> loadImages() async {
    final snapshot = await _db.collection('carousel').get();
    final imagesList = snapshot.docs
        .map((doc) => CarouselImage.fromFirestore(doc.data(),doc.id))
        .toList();
    images.value = imagesList;
  }
}

