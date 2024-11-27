import 'package:certify/core/constants/constants.dart';
import 'package:certify/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeImage extends StatelessWidget {
  const WelcomeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "WELCOME TO CERTIFY",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Int",
          ),
        ).afmPadding(
          EdgeInsets.only(
            bottom: 10.h,
          ),
        ),
        Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 10,
              child: Image.asset(
                EnvAssets.getImagePath("welcome"),
              ),
            ),
            const Spacer(),
          ],
        ).afmPadding(
          EdgeInsets.only(
            bottom: 10.h,
          ),
        ),
      ],
    );
  }
}
