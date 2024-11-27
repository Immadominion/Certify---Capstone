// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:certify/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web3modal_flutter/services/w3m_service/i_w3m_service.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final bool agreeTC;
  final void Function()? buttonOnPressed;
  final String pageCTA;
  final double pageCTASize;
  final Color color;
  final Color buttonTextColor;
  double height;
  double width;
  CustomButton({
    super.key,
    this.agreeTC = false,
    this.buttonOnPressed,
    required this.pageCTA,
    this.color = Colors.deepPurple,
    this.buttonTextColor = Colors.white,
    this.height = 45,
    this.width = 1,
    this.pageCTASize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint('INFO: $pageCTA button has been pressed');
        buttonOnPressed!();
      },
      child: agreeTC
          ? const SizedBox()
          : Container(
              height: height.h,
              width: width == 1
                  ? MediaQuery.of(context).size.width - 40.w
                  : width.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Text(
                pageCTA,
                style: TextStyle(
                  fontFamily: 'Int',
                  color: buttonTextColor,
                  fontSize: pageCTASize.sp,
                  fontWeight: FontWeight.w600,
                ),
              ).afmCenter,
            ).afmBorderRadius(
              BorderRadius.circular(10.r),
            ),
    );
  }
}

class CustomW3MButton extends StatelessWidget {
  final IW3MService service;
  final BaseButtonSize size;
  final String? avatar;
  final double height;
  final double width;

  const CustomW3MButton({
    super.key,
    required this.service,
    this.size = BaseButtonSize.regular,
    this.avatar,
    this.height = 55,
    this.width = 300,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h, // Example height using ScreenUtil
      width: width.w,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: W3MAccountButton(
        service: service,
        size: size,
        avatar: avatar,
      ),
    ).afmPadding(
      EdgeInsets.symmetric(horizontal: 20.w), // Adjust padding as needed
    );
  }
}
