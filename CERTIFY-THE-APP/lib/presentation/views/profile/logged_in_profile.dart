import 'package:certify/core/constants/constants.dart';
import 'package:certify/presentation/views/create/create_nft.dart';
import 'package:certify/presentation/views/profile/history.dart';
import 'package:certify/presentation/views/profile/owned_products_screen.dart';
import 'package:certify/presentation/views/profile/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/controllers/certify_dashboard_controller.dart';
import '../../../data/local/toast_service.dart';
import '../../../utils/locator.dart';
import '../manufacturer_home/manufacturer_dashboard.dart';
import '../shared_auth/signup_login_bottom_sheet.dart';
import 'logged_in_account_info.dart';

class LoggedInProfile extends StatefulWidget {
  const LoggedInProfile({super.key});

  @override
  State<LoggedInProfile> createState() => _LoggedInProfileState();
}

class _LoggedInProfileState extends State<LoggedInProfile> {
  String? _username;
  final String _userKey = 'name';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString(_userKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10.h,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        automaticallyImplyLeading: false,
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
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Int",
                      ),
                    ),
                    Text(
                      _username ?? 'User',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Int",
                      ),
                    ),
                  ],
                ),
                const EditableProfileAvatar(),
              ],
            ),
            SizedBox(height: 20.h),

            // Account Management Section
            Text(
              'Account Management',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                fontFamily: "Int",
              ),
            ),
            _buildProfileOption(
              context,
              icon: 'user-profile',
              title: 'Account Info',
              onTap: () {
                // Navigate to Account Info screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LoggedInAccountInfoWidget(
                      userName: 'Nigerian Breweries Plc',
                      userEmail: 'privacy.nbplc@heineken.com',
                      userIndustry: 'Alcoholic beverage',
                      userRcNumber: 'RC 613',
                    ),
                  ),
                );
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            _buildProfileOption(
              context,
              icon: 'wallet',
              title: 'Wallets',
              onTap: () {
                // Navigate to Wallets screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Wallet(),
                  ),
                );
              },
            ),

            SizedBox(height: 10.h),
            // Overview & Verification History Section
            Text(
              'Overview & Verification History',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                fontFamily: "Int",
              ),
            ),
            _buildProfileOption(
              context,
              icon: 'stack',
              title: 'Create Product',
              onTap: () {
                // Navigate to Create Products Screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CreateSingleNft(),
                  ),
                );
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            _buildProfileOption(
              context,
              icon: 'stack',
              title: 'Owned Products',
              onTap: () {
                // Navigate to Owned Products screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OwnedProductsScreen(),
                  ),
                );
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            _buildProfileOption(
              context,
              icon: 'user (2)',
              title: 'History',
              onTap: () {
                // Navigate to History screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HistoryScreen(),
                  ),
                );
              },
            ),
            SizedBox(height: 10.h),

            // Settings Section
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                fontFamily: "Int",
              ),
            ),
            _buildProfileOption(
              context,
              icon: 'settings',
              title: 'Account Settings',
              onTap: () {
                // Navigate to Account Settings screen
              },
            ),
            Divider(
              color: Theme.of(context).colorScheme.onSurface,
            ),
            Consumer(builder: (context, ref, index) {
              return _buildProfileOption(
                context,
                icon: 'help-square',
                title: 'Log out',
                onTap: () {
                  showCustomBottomSheet(
                    context: context,
                    title: "Log Out",
                    message: "Are you sure you want to log out?",
                    primaryButtonText: "Log Out",
                    primaryButtonAction: () async {
                      // Add logout functionality
                      clearUser() async {
                        final prefs = await SharedPreferences.getInstance();
                        final removeName = await prefs.remove('name');
                        final removeToken = await prefs.remove('token');

                        if (removeToken && removeName) {
                          locator<ToastService>().showErrorToast(
                            "You are logged out",
                          );

                          // Delay for async navigation operations
                          await Future.delayed(const Duration(milliseconds: 50),
                              () {
                            ref.read(dashBoardControllerProvider).setPage(0);

                            Navigator.pop(context);

                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const ManufacturerHome(),
                              ),
                            );
                          });
                        }
                      }

                      clearUser();
                    },
                    secondaryButtonText: "Go Back",
                    secondaryButtonAction: () {
                      Navigator.pop(context);
                    },
                  );
                },
              );
            })
          ],
        ),
      ),
    );
  }

  // Profile Option Widget
  Widget _buildProfileOption(BuildContext context,
      {required String icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: SvgPicture.asset(
        'assets/svgs/$icon.svg',
        height: 22.h,
        width: 22.w,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          fontFamily: "Int",
        ),
      ),
      trailing: SvgPicture.asset(
        EnvAssets.getSvgPath('arrow-forward'),
        height: 14.h,
        width: 14.w,
        color: Colors.grey,
      ),
      onTap: onTap,
    );
  }
}

class EditableProfileAvatar extends StatelessWidget {
  const EditableProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        CircleAvatar(
          radius: 31.r,
          backgroundColor:
              Theme.of(context).colorScheme.primary.withOpacity(0.1),
          backgroundImage: const AssetImage('assets/images/maltina.png'),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 24.w,
            height: 24.h,
            padding: EdgeInsets.all(2.w), // Padding for inner icon container
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primary
                    .withOpacity(0.7), // Background color for icon
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 3.r,
                )),
            child: Icon(
              Icons.edit,
              color: Colors.white,
              size: 14.sp, // Adjust icon size
            ),
          ),
        ),
      ],
    );
  }
}
