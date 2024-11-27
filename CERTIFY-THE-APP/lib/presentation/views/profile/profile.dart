import 'package:certify/core/constants/constants.dart';
import 'package:certify/presentation/views/profile/account_info.dart';
import 'package:certify/presentation/views/profile/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../shared_auth/signup_login_bottom_sheet.dart';
import '../signup/signup.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Track the selected gender and username
  String selectedGender = 'male';
  String? _username;
  final String _userKey = 'name';
  final String _genderKey = 'gender';

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Load gender and username from SharedPreferences
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString(_userKey);
      selectedGender = prefs.getString(_genderKey) ?? 'male'; // Default to male
    });
  }

  // Save selected gender to SharedPreferences
  Future<void> _saveGender(String gender) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_genderKey, gender);
  }

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
    _saveGender(gender); // Save gender preference
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10.h,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Profile,',
                      style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Int",
                      ),
                    ),
                    Text(
                      _username ?? 'User',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Int",
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  radius: 31.r,
                  backgroundColor:
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  backgroundImage: AssetImage(selectedGender == 'male'
                      ? 'assets/images/profile.png'
                      : 'assets/images/profile-female.png'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Gender Selection
            Center(
              child: Container(
                height: 130.h,
                width: MediaQuery.of(context).size.width - 60.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Male Avatar
                    GestureDetector(
                      onTap: () => _selectGender('male'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Male',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Int",
                              color: selectedGender == 'male'
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          CircleAvatar(
                            backgroundColor: selectedGender == 'male'
                                ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2)
                                : Colors.grey.withOpacity(0.1),
                            radius: 28.r,
                            backgroundImage: AssetImage(
                              selectedGender == 'male'
                                  ? 'assets/images/male.png'
                                  : 'assets/images/male-off.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Female Avatar
                    GestureDetector(
                      onTap: () => _selectGender('female'),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Female',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Int",
                              color: selectedGender == 'female'
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          CircleAvatar(
                            backgroundColor: selectedGender == 'female'
                                ? Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.2)
                                : Colors.grey.withOpacity(0.1),
                            radius: 28.r,
                            backgroundImage: AssetImage(
                              selectedGender == 'female'
                                  ? 'assets/images/female.png'
                                  : 'assets/images/female-off.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Profile Info Section
            ListTile(
              leading: SvgPicture.asset(
                EnvAssets.getSvgPath('user-profile'),
                height: 20.h,
                width: 20.w,
              ),
              title: Text(
                'Profile Info',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Int",
                ),
              ),
              trailing: SvgPicture.asset(
                EnvAssets.getSvgPath('arrow-forward'),
                height: 12.h,
                width: 12.w,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AccountInfoWidget(),
                  ),
                );
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            // History Section
            ListTile(
              leading: SvgPicture.asset(
                EnvAssets.getSvgPath('help-square'),
                height: 20.h,
                width: 20.w,
              ),
              title: Text(
                'History',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Int",
                ),
              ),
              trailing: SvgPicture.asset(
                EnvAssets.getSvgPath('arrow-forward'),
                height: 12.h,
                width: 12.w,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(),
                  ),
                );
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            // Sign Up/Login Section
            ListTile(
              leading: SvgPicture.asset(
                EnvAssets.getSvgPath('user (2)'),
                height: 20.h,
                width: 20.w,
              ),
              title: Text(
                'Sign Up/Login',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: "Int",
                ),
              ),
              trailing: SvgPicture.asset(
                EnvAssets.getSvgPath('arrow-forward'),
                height: 12.h,
                width: 12.w,
              ),
              onTap: () {
                showCustomBottomSheet(
                  context: context,
                  title: "Sign Up/Login",
                  message: "Sign Up/Login to get full access",
                  primaryButtonText: "Sign Up/Login",
                  primaryButtonAction: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
                    );
                  },
                  secondaryButtonText: "Go Back",
                  secondaryButtonAction: () {
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
