import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../controllers/topics_controller.dart';
import '../models/topic.dart';

class TopicsScreen extends StatelessWidget {
  final String courseId;

  const TopicsScreen({required this.courseId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TopicController(courseId: courseId));
    final topics = controller.topics;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 6, 180),
        elevation: 0,
        title: Text(
          'Topics',
          style: GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: Obx(
        () {
          if (topics.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
              ),
            );
          }
          return ListView.builder(
            itemCount: topics.length,
            itemBuilder: (context, index) {
              final topic = topics[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 2,
                  child: ListTile(
                    title: Text(
                      topic.name,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                   
                      // Do something when the topic is tapped
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
