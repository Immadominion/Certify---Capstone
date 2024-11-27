import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductBottomSheet extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String productDescription;
  final String manufacturer;
  final String authenticityStatus;

  const ProductBottomSheet({
    super.key,
    required this.imagePath,
    required this.productName,
    required this.productDescription,
    required this.manufacturer,
    required this.authenticityStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370.h,
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            child: Image.asset(
              imagePath,
              height: 190.h,
              width: double.infinity,
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(height: 17.h),

          // Product Information Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontFamily: "Int",
                ),
              ),
              Text(
                productDescription,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white70,
                  fontFamily: "Int",
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),

              // Manufacturer and Authenticity Status
              Text(
                'Manufacturer: $manufacturer',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
              Text(
                'Authenticity Status: $authenticityStatus',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white70,
                ),
              ),
            ],
          ).afmPadding(
            EdgeInsets.symmetric(
              horizontal: 30.sp,
            ),
          ),

          SizedBox(height: 15.h),

          // Go Back Button
          Center(
            child: CustomButton(
              pageCTA: "Go Back",
              buttonOnPressed: () {
                Navigator.pop(context);
              },
            ).afmPadding(
              EdgeInsets.only(
                bottom: 20.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// To display the bottom sheet
void showProductBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    backgroundColor: Colors.transparent,
    builder: (context) {
      return const ProductBottomSheet(
        imagePath: 'assets/images/maltina-full.png',
        productName: 'Maltina',
        productDescription: 'A popular non-alcoholic malt drink.',
        manufacturer: 'Nigerian Breweries Plc',
        authenticityStatus: 'Verified',
      );
    },
  );
}
