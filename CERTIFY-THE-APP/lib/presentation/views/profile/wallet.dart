import 'package:certify/core/constants/constants.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:certify/presentation/views/shared_widgets/header_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Wallet extends StatelessWidget {
  Wallet({super.key});

  // Sample data for wallets
  final List<Map<String, String>> wallets = [
    {
      'name': 'MetaMask',
      'address': '1A1zP1eP5QGefi2DMPTfTL5SLmv7...',
      'iconPath': 'assets/images/maltina.png',
    },
    {
      'name': 'Phantom',
      'address': '1A1zP1eP5QGefi2DMPTfTL5SLmv7...',
      'iconPath': 'assets/images/maltina.png',
    },
    {
      'name': 'TrustWallet',
      'address': '1A1zP1eP5QGefi2DMPTfTL5SLmv7...',
      'iconPath': 'assets/images/maltina.png',
    },
    {
      'name': 'Coinbase Wallet',
      'address': '1A1zP1eP5QGefi2DMPTfTL5SLmv7...',
      'iconPath': 'assets/images/maltina.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CertifyAppBar(
                text: 'Wallets',
                bottomPadding: 10,
              ),
              // Wallets List
              Expanded(
                child: ListView.separated(
                  itemCount: wallets.length,
                  separatorBuilder: (context, index) => SizedBox(height: 0.h),
                  itemBuilder: (context, index) {
                    final wallet = wallets[index];
                    return Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Row(
                        children: [
                          // Wallet Icon
                          Image.asset(
                            wallet['iconPath']!,
                            width: 35.w,
                            height: 35.h,
                          ),
                          SizedBox(width: 10.w),

                          // Wallet Name and Address
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  wallet['name']!,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontFamily: "Int",
                                  ),
                                ),
                                Text(
                                  wallet['address']!,
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: Colors.grey,
                                    fontFamily: "Int",
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () {},
                            child: SvgPicture.asset(
                              EnvAssets.getSvgPath('more-vertical'),
                              height: 24.h,
                              width: 24.w,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              CustomButton(
                pageCTA: "Add Wallet",
                height: 45.h,
                width: 300.w,
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
