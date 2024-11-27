import 'package:certify/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../manufacturer_home/manufacturer_dashboard.dart';
import 'verified_card.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    _checkIfOnboardingSeen();
  }

  Future<void> _checkIfOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    if (hasSeenOnboarding) {
      // If onboarding has been seen, navigate to the main screen
      _navigateToMainScreen();
    }
  }

  void _navigateToMainScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ManufacturerHome(),
      ),
    );
  }

  Future<void> _markOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    _navigateToMainScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Stack of Cards
                SizedBox(
                  height: 300.h,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationZ(-0.4),
                        child: const VerifiedCard(
                          imgName: 'trophy',
                          cardHeight: 200,
                          imgHeight: 120,
                          textCardHeight: 100,
                        ).afmPadding(
                          EdgeInsets.only(bottom: 50.sp, right: 25.w),
                        ),
                      ),
                      Transform(
                        alignment: Alignment.bottomRight,
                        transform: Matrix4.rotationZ(0.2),
                        child: const VerifiedCard(
                          imgName: 'indomie',
                          textCardHeight: 180,
                        ),
                      ),
                      // Main Verified Product Card
                      const VerifiedCard(
                        imgName: 'maltina',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  width: MediaQuery.of(context).size.width,
                ),
                // Welcome Text
                Text(
                  "Welcome to \nCertify!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Int",
                  ),
                ),
                SizedBox(height: 20.h),
                // Get Started Button
                SizedBox(
                  width: 300.w,
                  height: 55.h,
                  child: ElevatedButton(
                    onPressed: () async {
                      // Mark onboarding as seen and navigate
                      await _markOnboardingSeen();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      backgroundColor: const Color.fromRGBO(130, 70, 243, 1),
                    ),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontFamily: "Int",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
