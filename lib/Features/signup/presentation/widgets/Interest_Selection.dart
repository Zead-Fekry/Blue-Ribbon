import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/shared-widgets/spacing.dart';
import '../../../../core/styles/colors/app_colors.dart';

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

       await sendVerificationEmail(widget.user!);

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
  Future<void> sendVerificationEmail(User user) async {
    ActionCodeSettings actionCodeSettings = ActionCodeSettings(
      url: "https://newsletterapp.page.link/start?uid=${user.uid}",
      handleCodeInApp: true,
      androidInstallApp: true,
      androidMinimumVersion: "1",
      androidPackageName: "com.example.newsletterapp",
      iOSBundleId: "com.example.newsletterapp",
    );

    try {
      await user.sendEmailVerification(actionCodeSettings);
      print("Verification email sent.");
    } catch (e) {
      print("Error sending email verification: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Select Your Interests"),
      automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainBlue,
      ),
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
            style: ElevatedButton.styleFrom(
              backgroundColor: selectedInterests.isEmpty ? Colors.grey : AppColors.mainBlue,
              disabledBackgroundColor: Colors.grey, // Ensure it looks disabled when inactive
            ),
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
