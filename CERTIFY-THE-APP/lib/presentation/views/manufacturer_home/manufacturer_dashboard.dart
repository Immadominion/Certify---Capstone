import 'package:certify/core/constants/constants.dart';
import 'package:certify/data/controllers/certify_dashboard_controller.dart';
import 'package:certify/presentation/views/manufacturer_home/manufacturer_home.dart';
import 'package:certify/presentation/views/profile/profile.dart';
import 'package:certify/presentation/views/profile/logged_in_profile.dart'; // Make sure this import exists
import 'package:certify/presentation/views/scan_code/scan_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManufacturerHome extends HookConsumerWidget {
  const ManufacturerHome({super.key});

  @override
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('Consumer Home rebuilt: ${DateTime.now()}');
    String selectedGender = 'male';

    Future<void> _loadImage() async {
      final prefs = await SharedPreferences.getInstance();
      selectedGender = prefs.getString('gender') ?? 'male';
    }

    _loadImage();
    // Create a FutureBuilder to handle the async SharedPreferences check
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final prefs = snapshot.data;
          final hasToken = prefs?.getString('token') != null;

          final List<Widget> tabs = [
            const Home(),
            // Conditionally return LoggedInProfile or Profile based on SharedPreferences
            hasToken ? const LoggedInProfile() : const Profile(),
          ];

          final dashboardController = ref.watch(dashBoardControllerProvider);
          final selectedPageIndex = dashboardController.myPage;

          return Scaffold(
            body: tabs[selectedPageIndex],
            bottomNavigationBar: Padding(
              padding: EdgeInsets.only(bottom: 7.sp),
              child: SizedBox(
                height: 100.h,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 85.h,
                        width: 85.w,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.scrim,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 60.h,
                        width: 280.w,
                        margin: EdgeInsets.all(20.sp),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.scrim,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                dashboardController.switchPage(0);
                                HapticFeedback.lightImpact();
                              },
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                child: SvgPicture.asset(
                                  height: 24.h,
                                  width: 24.w,
                                  EnvAssets.getSvgPath('home'),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 60.h,
                              width: 80.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                dashboardController.switchPage(1);
                                HapticFeedback.lightImpact();
                              },
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                child: Image.asset(
                                  EnvAssets.getImagePath(
                                    selectedGender == 'male'
                                        ? 'profile'
                                        : 'profile-female',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CertifiedScanner(),
                            ),
                          );
                          HapticFeedback.lightImpact();
                        },
                        child: Container(
                          height: 75.h,
                          width: 75.w,
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(3.sp),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .inversePrimary
                                .withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            height: 66.h,
                            width: 66.w,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(3.sp),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              height: 60.h,
                              width: 60.w,
                              padding: EdgeInsets.all(10.sp),
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(130, 70, 240, 1),
                                shape: BoxShape.circle,
                              ),
                              child: SvgPicture.asset(
                                height: 30.h,
                                width: 30.w,
                                EnvAssets.getSvgPath('qr-code'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // Show loading indicator while SharedPreferences is being fetched
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
