import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared_widgets/header_pad.dart';
import '../shared_widgets/text_input.dart';

class OwnedProductsScreen extends StatefulWidget {
  const OwnedProductsScreen({super.key});

  @override
  State<OwnedProductsScreen> createState() => _OwnedProductsScreenState();
}

class _OwnedProductsScreenState extends State<OwnedProductsScreen> {
  final TextEditingController searchController = TextEditingController();
  // Sample data for products
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Maltina',
      'description': 'A popular non-alcoholic malt drink.',
      'manufacturer': 'Nigerian Breweries Plc',
      'status': 'Verified',
      'imagePath': 'assets/images/maltina-full.png',
    },
    {
      'name': 'Star',
      'description': 'A well-known alcoholic drink.',
      'manufacturer': 'Nigerian Breweries Plc',
      'status': 'Verified',
      'imagePath': 'assets/images/maltina-full.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CertifyAppBar(
                text: 'Owned Products',
                bottomPadding: 10,
              ),
              // Search Bar
              CustomTextField(
                  labelText: 'Search',
                  prefixIcon: 'search',
                  suffixIcon: 'filter',
                  controller: searchController),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  'Sort by: Recent',
                  style: TextStyle(
                    color: const Color.fromRGBO(51, 51, 51, .5),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Product List
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.h),
                      child: Container(
                        height: 400.h,
                        width: MediaQuery.of(context).size.width - 60.w,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(51, 51, 51, 1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Image
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.r),
                                topRight: Radius.circular(15.r),
                              ),
                              child: Image.asset(
                                product['imagePath']!,
                                width: double.infinity,
                                height: 200.h,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // Product Details
                            Padding(
                              padding: EdgeInsets.only(
                                left: 20.w,
                                right: 20.w,
                                top: 10.h,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name']!,
                                    style: TextStyle(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontFamily: "Int",
                                    ),
                                  ),
                                  Text(
                                    product['description']!,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.white70,
                                      fontFamily: "Int",
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Manufacturer: ${product['manufacturer']}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  Text(
                                    'Authenticity Status: ${product['status']}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Edit and Delete Buttons
                            Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomButton(
                                      pageCTA: "Edit",
                                      width: MediaQuery.of(context).size.width -
                                          100.w,
                                    ),
                                    CustomButton(
                                      pageCTA: "Delete",
                                      width: MediaQuery.of(context).size.width -
                                          100.w,
                                    ).afmPadding(
                                      EdgeInsets.only(
                                        bottom: 5.h,
                                        top: 2.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
