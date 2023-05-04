import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zerowaste/controllers/left_over_controller.dart';
import 'package:zerowaste/pages/payment.dart';

import '../controllers/carousel_controller.dart';
import '../controllers/courses_controller.dart';
import '../models/foods.dart';
import 'available_food.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Zero Waste',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              buildCarousel(context),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Available Left overs',
                  style: GoogleFonts.poppins(color: Colors.black, fontSize: 17),
                ),
              ),
              buildLeftOver(context),
              buildGridList()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCarousel(BuildContext context) {
    final carouselController = Get.put(CarouselControllerT());
    return Obx(() {
      if (carouselController.images.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
          ),
        );
      }
      return CarouselSlider.builder(
        options: CarouselOptions(
          // height: MediaQuery.of(context).size.height * 0.40,
          viewportFraction: 1.0,
          autoPlay: true,

          autoPlayInterval: const Duration(seconds: 3),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
        ),
        itemCount: carouselController.images.length,
        itemBuilder: (BuildContext context, int index, _) {
          final image = carouselController.images[index];
          return Stack(
            children: [
              CachedNetworkImage(
                imageUrl: image.imageUrl,
                width: MediaQuery.of(context).size.width,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.cover,
              ),
              Positioned(
                  bottom: 10,
                  left: 10,
                  child: Text(
                    image.name!,
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 25),
                  ))
            ],
          );
        },
      );
    });
  }

  Widget buildLeftOver(BuildContext context) {
    final carouselController = Get.put(LeftOverController());
    return Obx(() {
      if (carouselController.images.isEmpty) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
          ),
        );
      }
      return CarouselSlider.builder(
        options: CarouselOptions(
          // height: MediaQuery.of(context).size.height * 0.40,
          viewportFraction: 0.7,
          autoPlay: true,

          autoPlayInterval: const Duration(seconds: 3),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
        ),
        itemCount: carouselController.images.length,
        itemBuilder: (BuildContext context, int index, _) {
          final image = carouselController.images[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: image.imageUrl,
                    width: MediaQuery.of(context).size.width,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    right: 10,
                    bottom: 10,
                    child: ElevatedButton(
                      onPressed: () {
/////////////////////
// when buy button is pressed
                        Get.to(() => PaymentPage(
                              imageUrl: image.imageUrl,
                              product: image.name,
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 236, 16, 0)),
                      child: Text(
                        'Buy',
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
                    )),
                Positioned(
                    bottom: 10,
                    left: 10,
                    child: Container(
                      height: 40,
                      width: 100,
                      color: Colors.black.withOpacity(0.3),
                      child: Center(
                        child: Text(
                          image.name!,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 17),
                        ),
                      ),
                    ))
              ],
            ),
          );
        },
      );
    });
  }

  Widget buildGridList() => Expanded(child: Obx(() {
        final controller = Get.put(CoursesController());
        final courses = controller.courses;
        if (courses.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          );
        }
        return GridView.builder(
          itemCount: courses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            final Course course = courses[index];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  switch (index) {
                    case 0:
                      Get.to(() => AvailableFoodPage());
                      break;
                    case 1:
                      break;
                    default:
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                        imageUrl: course.imageUrl,
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        course.name,
                        style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }));
}
