import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/certify_dashboard_controller.dart';
import 'package:certify/data/controllers/certify_login_controller.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/manufacturer_home/components/my_fade_route.dart';
import 'package:certify/presentation/views/manufacturer_home/manufacturer_dashboard.dart';
import 'package:certify/presentation/views/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:certify/core/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/local/toast_service.dart';
import '../../../utils/locator.dart';
import '../shared_widgets/text_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SvgPicture.asset(
                            EnvAssets.getSvgPath('arrow-left-double'),
                            width: 24.w,
                            height: 24.h,
                            color: Colors.black,
                          ),
                        ),

                        Text(
                          "Login To Your \nAccount",
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Int",
                          ),
                          textAlign: TextAlign.left,
                        ).afmPadding(EdgeInsets.only(
                            left: 35.w, bottom: 30.h, top: 10.h)),

                        CustomTextField(
                          labelText: 'Email',
                          prefixIcon: 'email',
                          keyboardType: TextInputType.emailAddress,
                          controller: email,
                        ).afmPadding(EdgeInsets.only(bottom: 20.h)),
                        // Email Field

                        // Password Field
                        CustomTextField(
                          labelText: 'Password',
                          prefixIcon: 'password',
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                          controller: password,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Remember Me Checkbox
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rememberMe = !rememberMe;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                EnvAssets.getSvgPath('checkmark-square'),
                                width: 18.w,
                                height: 18.h,
                                fit: BoxFit.contain,
                                color: rememberMe
                                    ? Theme.of(context).colorScheme.primary
                                    : const Color.fromRGBO(51, 51, 51, .5),
                              ),
                              SizedBox(
                                width: 3.sp,
                              ),
                              Text(
                                "Remember me",
                                style: TextStyle(
                                  fontFamily: "Int",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15.sp,
                        ),

                        Consumer(builder: (context, ref, child) {
                          return CustomButton(
                            pageCTA: "Login",
                            buttonOnPressed: () {
                              ref
                                  .read(certifyLoginController)
                                  .signIn(
                                    email.text,
                                    password.text,
                                  )
                                  .then((value) {
                                if (value) {
                                  ref
                                      .read(dashBoardControllerProvider)
                                      .setPage(0);

                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ManufacturerHome(),
                                    ),
                                    (Route<dynamic> route) => false,
                                  );
                                }
                              });
                            },
                          );
                        }),

                        // Already have an account? Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontFamily: "Int",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigate to signup screen
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const SignupScreen(),
                                  ),
                                );
                              },
                              isSemanticButton: false,
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontFamily: "Int",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Consumer(builder: (context, ref, index) {
              return ref.watch(certifyLoginController).loadingState ==
                      LoadingState.loading
                  ? const TransparentLoadingScreen()
                  : const SizedBox();
            }),
          ],
        ));
  }
}
