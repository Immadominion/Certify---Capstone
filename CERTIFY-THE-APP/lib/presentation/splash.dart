import 'dart:async';
import 'package:certify/main.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CertifySplash extends StatefulWidget {
  const CertifySplash({super.key});

  @override
  CertifySplashState createState() => CertifySplashState();
}

class CertifySplashState extends State<CertifySplash> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        Navigator.of(context).pushReplacement(
          PageTransition(
            type: PageTransitionType.bottomToTop,
            child: const MyApp(),
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Image.asset(
          "assets/images/certify.png",
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
