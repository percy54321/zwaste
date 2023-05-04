import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/auth_controller.dart';

class PaymentPage extends StatefulWidget {
  final String? product;
  final String imageUrl;

  const PaymentPage({super.key, this.product, required this.imageUrl});
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final AuthController _authController = Get.find();
  // Declare variables for phone number and amount
  late String _phoneNumber, _amount;

  // Create a form key to validate the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Make Payment',
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  CachedNetworkImage(
                    height: 200,
                    width: 200,
                    imageUrl: widget.imageUrl,
                  ),
                  Text(
                    widget.product!,
                    style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Please enter a phone number';
                      }
                      return null;
                    },
                    onSaved: (input) => _phoneNumber = input!,
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.poppins(color: Colors.black),
                      labelText: 'Phone Number',
                    ),
                  ),
                  TextFormField(
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Please enter an amount';
                      }
                      return null;
                    },
                    onSaved: (input) => _amount = input!,
                    decoration: InputDecoration(
                      labelStyle: GoogleFonts.poppins(color: Colors.black),
                      labelText: 'Amount',
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: makePayment,
                    child: Text(
                      'Make Payment',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to make payment
  void makePayment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        // Store payment information in Firestore database
        await FirebaseFirestore.instance.collection('payments').add({
          'product': widget.product,
          'productImage': widget.imageUrl,
          'phoneNumber': _phoneNumber,
          'amount': _amount,
          'userId': _authController.firebaseUser.value?.uid,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment successful'),
          ),
        );
        Navigator.pop(context);
      } catch (e) {}
    }
  }
}
