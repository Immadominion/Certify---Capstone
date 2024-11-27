import 'package:certify/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/env_assets.dart';

class VerifiedCard extends StatelessWidget {
  final String imgName;
  final double textCardHeight;
  final double cardHeight;
  final double imgHeight;

  const VerifiedCard({
    super.key,
    required this.imgName,
    this.textCardHeight = 120,
    this.cardHeight = 300,
    this.imgHeight = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.w,
      height: cardHeight.h,
      child: Stack(
        children: [
          Card(
            elevation: 5.sp,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                  child: Image.asset(
                    EnvAssets.getImagePath(imgName),
                    height: imgHeight.h,
                    width: 200.w,
                    fit: BoxFit.cover,
                  ),
                ).afmPadding(EdgeInsets.all(5.sp)),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 5,
            right: 5,
            child: Container(
              height: textCardHeight.h,
              width: 1000.w,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.all(Radius.circular(20.r))),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      EnvAssets.getSvgPath('checkmark-badge'),
                      height: 30.h,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Verified",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Int",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
