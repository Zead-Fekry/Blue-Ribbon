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
  List<String> interests = ["Apple", "Business", "WallStreetMarket"];
  List<String> selectedInterests = [];
  bool isLoading = false;

  void _saveInterests() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
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
        isLoading = false;
      });
    }
  }
  Future<String> createDynamicLink(String uid) async {
    final String longDynamicLink = Uri.parse(
        "https://newsletterapp.page.link/?" // Your Firebase Dynamic Link domain
            "link=https://newsletterapp.com/news?uid=$uid" // Deep link with UID
            "&apn=com.example.news_letter_app" // Android Package
            "&ibi=com.example.newsLetterApp" // iOS Bundle ID
    ).toString();

    return longDynamicLink;
  }
  Future<void> sendVerificationEmail(User user) async {
    String dynamicLink = await createDynamicLink(user.uid);
    ActionCodeSettings actionCodeSettings = ActionCodeSettings(
      url:dynamicLink,
      handleCodeInApp: true,
      androidInstallApp: true,
      androidMinimumVersion: "1",
      androidPackageName: "com.example.news_letter_app",
      iOSBundleId: "com.example.news_letter_app",
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
