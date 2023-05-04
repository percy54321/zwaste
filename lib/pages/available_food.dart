import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zerowaste/controllers/available_food_controller.dart';
import 'package:zerowaste/models/avaialble_food.dart';

class AvailableFoodPage extends StatelessWidget {
  const AvailableFoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Available Food',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
        
      ),
      body: Column(children: [
        buildListView()
      ],),
    );
  }

  Widget buildListView() => Expanded(
        child: Obx(
          () {
            final controller = Get.put(AvailableFoodsController());
            final afoods = controller.afoods;
            if (afoods.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            }
            return ListView.builder(
              itemCount: afoods.length,
              padding: EdgeInsets.zero,
              itemBuilder: (BuildContext context, int index) {
                final AvailableFoodImage afood = afoods[index];
                return ListTile(
                  leading: CachedNetworkImage(imageUrl: afood.imageUrl,height: 50,width: 50,),
                  title: Text(
                    afood.name!,
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),

                );
              },
            );
          },
        ),
      );
}
