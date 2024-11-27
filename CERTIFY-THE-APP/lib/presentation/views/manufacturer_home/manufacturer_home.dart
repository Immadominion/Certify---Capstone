import 'package:certify/core/constants/constants.dart';
import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/presentation/views/manufacturer_home/products_bottom_sheet.dart';
import 'package:certify/presentation/views/profile/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/controllers/theme_notifier.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final PageController _pageController = PageController(viewportFraction: 0.6);
  double _currentPage = 0;
  String? _username;
  final String _userKey = 'name';
  String selectedGender = 'male';

  @override
  void initState() {
    super.initState();
    _loadUsername();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString(_userKey);
      selectedGender = prefs.getString('gender') ?? 'male';
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning 👋';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon 👋';
    } else {
      return 'Good Evening 👋';
    }
  }

  @override
  Widget build(BuildContext context) {
    final dynamic isDarkMode = ref.watch(themeProvider).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10.h,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customAppBar(isDarkMode)
                  .afmPadding(EdgeInsets.symmetric(horizontal: 30.w)),
              SizedBox(height: 15.h),
              _buildNewProductsSection(),
              SizedBox(height: 15.h),
              _buildScanHistorySection()
                  .afmPadding(EdgeInsets.symmetric(horizontal: 30.w)),
            ],
          ),
        ),
      ),
    );
  }

  Widget customAppBar(bool isDarkMode) {
    return Row(
      children: [
        CircleAvatar(
          radius: 25.r,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Image.asset(
            EnvAssets.getImagePath(
              selectedGender == 'male' ? 'profile' : 'profile-female',
            ),
          ),
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getGreetingMessage(), // Use the dynamic greeting
              style: TextStyle(
                fontSize: 13.sp,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
                fontFamily: "Int",
              ),
            ),
            Text(
              _username ?? 'User',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "Int",
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            // Add night mode toggle functionality

            ref.read(themeProvider.notifier).toggleTheme();
          },
          icon: SvgPicture.asset(
            width: 30.w,
            height: 30.h,
            EnvAssets.getSvgPath(!isDarkMode ? 'dark' : 'sun'),
          ),
        ),
      ],
    );
  }

  Widget _buildNewProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'New Products',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: "Int",
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigate to "See All" products page
              },
              child: Text(
                'See All',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Theme.of(context).colorScheme.primary,
                  fontFamily: "Int",
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ).afmPadding(
          EdgeInsets.symmetric(horizontal: 30.sp),
        ),
        SizedBox(height: 10.h),
        _buildProductCarousel(),
      ],
    );
  }

  Widget _buildProductCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 270.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: 5, // Number of items in the carousel
            itemBuilder: (context, index) {
              // Determine the height based on whether the item is in focus
              double height = (_currentPage.round() == index) ? 250.h : 230.h;

              return GestureDetector(
                onTap: () {
                  showProductBottomSheet(context);
                },
                child: Center(
                  child: Container(
                    height: height,
                    width: 200.w,
                    padding: EdgeInsets.all(7.sp),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5.sp,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context)
                              .colorScheme
                              .scrim
                              .withOpacity(.4),
                          offset: const Offset(2, 2),
                          blurRadius: 8.r,
                          blurStyle: BlurStyle.normal,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15.r),
                      color: Theme.of(context).colorScheme.primary,
                      image: DecorationImage(
                        image: AssetImage(
                          EnvAssets.getImagePath(
                            'maltina',
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.h),
        _buildDotIndicator(5) // Pass the number of items in the carousel
      ],
    );
  }

  Widget _buildDotIndicator(int itemCount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 8.h,
          width: _currentPage.round() == index ? 30.w : 8.w,
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: _currentPage.round() == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface.withOpacity(.2),
            borderRadius: BorderRadius.circular(200.r),
          ),
        );
      }),
    );
  }

  Widget _buildScanHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HistoryScreen(),
              ),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Scan History',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Int",
                ),
              ),
              SvgPicture.asset(
                EnvAssets.getSvgPath("hyperlink"),
                width: 20.w,
                height: 22.h,
              ),
            ],
          ),
        ),
        // SizedBox(height: 10.h),
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return const HistoryItem(
                name: 'Maltina',
                date: 'Oct 18th, 11:00:00',
                status: 'Verified',
              );
            },
          ),
        ),
      ],
    );
  }
}
