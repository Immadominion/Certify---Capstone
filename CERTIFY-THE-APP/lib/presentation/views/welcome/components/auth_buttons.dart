import 'package:certify/presentation/views/home/home.dart';
import 'package:certify/presentation/views/login/login_screen.dart';
import 'package:certify/presentation/views/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthFieldBtn extends StatelessWidget {
  const AuthFieldBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              elevation: 5.h,
              fixedSize: Size.fromHeight(
                40.h,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
            child: Text(
              "Login".toUpperCase(),
              style: const TextStyle(
                fontFamily: "Int",
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignupScreen();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              elevation: 5.h,
              fixedSize: Size.fromHeight(
                40.h,
              ),
            ),
            child: Text(
              "Sign Up".toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "Int",
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CertifiedHome();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              elevation: 5.h,
              fixedSize: Size.fromHeight(
                40.h,
              ),
            ),
            child: Text(
              "be a guest".toUpperCase(),
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "Int",
              ),
            ),
          ),
        ),
      ],
    );
  }
}
