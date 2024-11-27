import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomSheet extends StatelessWidget {
  final String title;
  final String message;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback primaryButtonAction;
  final VoidCallback secondaryButtonAction;

  const CustomBottomSheet({
    super.key,
    required this.title,
    required this.message,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.primaryButtonAction,
    required this.secondaryButtonAction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 305.h,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.sp),
          topRight: Radius.circular(20.sp),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              fontFamily: "Int",
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color.fromRGBO(51, 51, 51, 0.5),
              fontFamily: "Int",
            ),
          ),
          SizedBox(height: 30.h),
          CustomButton(
            pageCTA: primaryButtonText,
            pageCTASize: 18,
            buttonOnPressed: primaryButtonAction,
          ),
          SizedBox(height: 10.h),
          CustomButton(
            pageCTA: secondaryButtonText,
            pageCTASize: 18,
            color: Theme.of(context).colorScheme.onTertiaryContainer,
            buttonOnPressed: secondaryButtonAction,
            buttonTextColor: Theme.of(context).colorScheme.primaryContainer,
          ),
        ],
      ),
    );
  }
}

void showCustomBottomSheet({
  required BuildContext context,
  required String title,
  required String message,
  required String primaryButtonText,
  required VoidCallback primaryButtonAction,
  required String secondaryButtonText,
  required VoidCallback secondaryButtonAction,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => CustomBottomSheet(
      title: title,
      message: message,
      primaryButtonText: primaryButtonText,
      primaryButtonAction: primaryButtonAction,
      secondaryButtonText: secondaryButtonText,
      secondaryButtonAction: secondaryButtonAction,
    ),
  );
}
