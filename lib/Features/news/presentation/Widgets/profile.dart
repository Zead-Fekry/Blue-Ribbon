import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/shared-widgets/spacing.dart';
import '../../../../core/styles/colors/app_colors.dart';

class Profile extends StatefulWidget {
  final String? Userid;

  const Profile({super.key, required this.Userid});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<String> interests = ["Apple", "Business", "WallStreetMarket"];
  List<String> selectedInterests = [];
  bool isLoading = false;

  void _saveInterests() async {
    if (isLoading || widget.Userid == null) return;
    setState(() {
      isLoading = true; // Show loading indicator
    });

    try {
      await FirebaseFirestore.instance
          .collection("UserInterests")
          .doc(widget.Userid)
          .update({
        "interests": selectedInterests,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Interests saved successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving interests: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
      Navigator.pushNamed(
        context,
        Routes.NewsScreen,
        arguments: {
          "interests": interests,
          "userId": widget.Userid,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add More Interests"),
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
          verticalSpace(20),
          isLoading
              ? CircularProgressIndicator() // Show loading when processing
              : ElevatedButton(
                  onPressed: selectedInterests.isEmpty ? null : _saveInterests,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedInterests.isEmpty
                        ? Colors.grey
                        : AppColors.mainBlue,
                    disabledBackgroundColor:
                        Colors.grey, // Ensure it looks disabled when inactive
                  ),
                  child: Text("Continue"),
                ),
        ],
      ),
    );
  }
}
