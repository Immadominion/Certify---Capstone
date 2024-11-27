import 'package:certify/core/theme/env_theme_manager.dart';
import 'package:certify/data/controllers/certify_dashboard_controller.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/splash.dart';
import 'package:certify/presentation/views/manufacturer_home/manufacturer_dashboard.dart';
import 'package:certify/presentation/views/shared_auth/onboarding_screen.dart';
import 'package:certify/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/controllers/theme_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(
    ProviderScope(
      child: OKToast(
        child: MaterialApp(
          title: 'Certify',
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: const CertifySplash(),
        ),
      ),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late Future<String> getEmailFuture;
  late final DashBoardController screenController =
      ref.read(dashBoardControllerProvider);
  // Clear all SharedPreferences

  // This widget is the root of your application.
  @override
  void initState() {
    getEmailFuture = screenController.getEmail();
    // clearUser();
    super.initState();
  }

  clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider).isDarkMode;
    debugPrint(
        "The screen is on >> ${isDarkMode ? 'Dark mode' : 'Light mode'}");
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          title: "Certify",
          debugShowCheckedModeBanner: false,
          darkTheme: EnvThemeManager.darkTheme,
          theme: EnvThemeManager.lightTheme,
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: Stack(
            children: [
              FutureBuilder<String?>(
                future: screenController.getEmail(),
                builder: ((context, snapshot) {
                  String? email = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (email == null || email == "") {
                      return const OnboardingScreen();
                    } else {
                      return const OnboardingScreen();
                    }
                  } else {
                    return const TransparentLoadingScreen();
                  }
                }),
              )
            ],
          ),
        );
      },
    );
  }
}
