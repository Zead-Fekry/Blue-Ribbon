import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../news/presentation/screens/News.dart';

class DeepLinkHandler extends StatefulWidget {
  @override
  _DeepLinkHandlerState createState() => _DeepLinkHandlerState();
}

class _DeepLinkHandlerState extends State<DeepLinkHandler> {
  @override
  void initState() {
    super.initState();
    _handleInitialDynamicLink();
    _handleForegroundDynamicLinks();
  }

  /// Handles deep links when the app is launched from a closed state.
  Future<void> _handleInitialDynamicLink() async {
    final PendingDynamicLinkData? data = await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      _navigateFromLink(data.link);
    }
  }

  /// Listens for deep links while the app is in the foreground.
  void _handleForegroundDynamicLinks() {
    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData? data) {
      if (data?.link != null) {
        _navigateFromLink(data!.link);
      }
    }).onError((error) {
      print('Deep link error: $error');
    });
  }

  /// Processes the deep link and navigates accordingly.
  void _navigateFromLink(Uri deepLink) async {
    if (!mounted) return;

    String? uid = deepLink.queryParameters["uid"];
    if (uid != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("UserInterests").doc(uid).get();

        if (userDoc.exists) {
          List<String> interests = List<String>.from(userDoc.get("interests"));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NewsScreen(interest: interests.join(", "))),
          );
        }
      } catch (e) {
        print("Error fetching user interests: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()), // Show loader while processing the link
    );
  }
}
