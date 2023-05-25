import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:qr/waiter.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  bool isVerified=false;
  Timer? timer;
  @override
  void dispose() {
  timer!.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    timer= Timer(Duration(milliseconds: 200), (() => checkEmailVerified()));
    
    return isVerified? Column(
      children: [
        Text("YOUR ARE VERIFIED GO PLAY FOOTBALLMANAGER!")
      ],
    )  :Scaffold(
      appBar: AppBar(title: Text("Verify Email")),
      body: Column(
        children: [
            Text("Verification link has been sent to your email. Please open your email and verify it!"),
            SizedBox(
              height: 20,
            ),
            InkWell(
  onTap:  openGmail, // Image tapped
  splashColor: Colors.white10, // Splash color over image
  child: Ink.image(
    fit: BoxFit.cover, // Fixes border issues
    width: 70,
    height: 45,
    image: AssetImage(
      'assets/image21.png',
    ),
  ),
    )
        ],
      ),
    );
  }

  Future checkEmailVerified() async{
      print("Test");
         await FirebaseAuth.instance.currentUser!.reload();
        setState(() {
          isVerified=FirebaseAuth.instance.currentUser!.emailVerified;
        });


     }

  Future<void> openGmail() async {
    InstalledApps.startApp('com.google.android.gm');
  }
}