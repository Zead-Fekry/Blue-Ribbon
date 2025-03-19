import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/shared-widgets/spacing.dart';

class InterestSelectionScreen extends StatefulWidget {
  final User? user;
  const InterestSelectionScreen({Key? key, required this.user}) : super(key: key);

  @override
  _InterestSelectionScreenState createState() => _InterestSelectionScreenState();
}

class _InterestSelectionScreenState extends State<InterestSelectionScreen> {
  List<String> interests = ["Apple", "Tesla", "Business", "WallStreetMarket"];
  List<String> selectedInterests = [];
  bool isLoading = false; // Track loading state

  void _saveInterests() async {
    if (isLoading) return;

    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      await FirebaseFirestore.instance.collection('UserInterests').doc(widget.user?.uid).set({
        'email': widget.user?.email,
        'interests': selectedInterests,
      });

      await widget.user?.sendEmailVerification();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmailConfirmationScreen()),
      );
    } catch (e) {
      print("Error saving interests: $e");
    } finally {
      setState(() {
        isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Your Interests")),
      body: Column(
        children: [
          ...interests.map((interest) => CheckboxListTile(
            title: Text(interest),
            value: selectedInterests.contains(interest),
            onChanged: (bool? selected) {
              setState(() {
                if (selected == true) {
                  selectedInterests.add(interest);
                } else {
                  selectedInterests.remove(interest);
                }
              });
            },
          )),
            verticalSpace( 20),
          isLoading
              ? CircularProgressIndicator() // Show loading when processing
              : ElevatedButton(
            onPressed: selectedInterests.isEmpty ? null : _saveInterests,
            child: Text("Continue"),
          ),
        ],
      ),
    );
  }
}

class EmailConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Check your email for confirmation link"),
      ),
    );
  }
}
