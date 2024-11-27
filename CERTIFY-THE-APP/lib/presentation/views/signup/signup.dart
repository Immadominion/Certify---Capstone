import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/certify_sign_up_controller.dart';
import 'package:certify/presentation/views/login/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/enum.dart';
import '../../../core/constants/env_assets.dart';
import '../../../data/controllers/certify_dashboard_controller.dart';
import '../../../data/local/toast_service.dart';
import '../../../utils/locator.dart';
import '../../general_components/cta_button.dart';
import '../../general_components/shared_loading.dart';
import '../manufacturer_home/manufacturer_dashboard.dart';
import '../shared_widgets/text_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  late bool rememberMe;
  late final TextEditingController name;
  late final TextEditingController email;
  late final TextEditingController password;
  late final TextEditingController confirmPassword;

  @override
  void initState() {
    super.initState();
    rememberMe = false;
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: 100.h,
            ), // Extra space to avoid overlap with bottom column
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
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
                      "Create Your \nAccount",
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Int",
                      ),
                      textAlign: TextAlign.left,
                    ).afmPadding(
                        EdgeInsets.only(left: 35.w, bottom: 30.h, top: 10.h)),
                    CustomTextField(
                      labelText: 'Company Name',
                      prefixIcon: 'user',
                      keyboardType: TextInputType.name,
                      controller: name,
                    ).afmPadding(EdgeInsets.only(bottom: 10.h)),
                    CustomTextField(
                      labelText: 'Email',
                      prefixIcon: 'email',
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
                    ).afmPadding(EdgeInsets.only(bottom: 10.h)),
                    CustomTextField(
                      labelText: 'Password',
                      prefixIcon: 'password',
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      controller: password,
                    ).afmPadding(EdgeInsets.only(bottom: 10.h)),
                    CustomTextField(
                      labelText: 'Confirm Password',
                      prefixIcon: 'password',
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      controller: confirmPassword,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Bottom column
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
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
                          color: rememberMe
                              ? Theme.of(context).colorScheme.primary
                              : const Color.fromRGBO(51, 51, 51, .5),
                        ),
                        SizedBox(width: 3.sp),
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
                  SizedBox(height: 15.sp),
                  Consumer(builder: (context, ref, child) {
                    return CustomButton(
                      pageCTA: "Sign Up",
                      buttonOnPressed: () {
                        ref
                            .read(certifySignUpController)
                            .signUp(name.text, email.text, password.text)
                            .then((value) {
                          if (value) {
                            ref.read(dashBoardControllerProvider).setPage(0);
                            locator<ToastService>().showErrorToast(
                              "Account Creation Successful",
                            );


                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const ManufacturerHome(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          }
                        });
                      },
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontFamily: "Int",
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
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
              ),
            ),
          ),
          Consumer(builder: (context, ref, index) {
            return ref.watch(certifySignUpController).loadingState ==
                    LoadingState.loading
                ? const TransparentLoadingScreen()
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}
