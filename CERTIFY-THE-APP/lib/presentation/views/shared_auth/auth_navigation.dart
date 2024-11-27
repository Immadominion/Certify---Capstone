import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:certify/presentation/views/home/home.dart';
import 'package:certify/presentation/views/login/login_screen.dart';
import 'package:certify/presentation/views/shared_auth/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import '../manufacturer_home/manufacturer_dashboard.dart';
import '../scan_code/scan_code.dart';

class CertifyAuthNavigator extends StatefulWidget {
  const CertifyAuthNavigator({super.key});

  @override
  State<CertifyAuthNavigator> createState() => _CertifyAuthNavigatorState();
}

class _CertifyAuthNavigatorState extends State<CertifyAuthNavigator> {
  final _w3mService = W3MService(
    projectId: '2009f3949892128ca51c1d44fd59e939',
    metadata: const PairingMetadata(
      name: 'Web3Modal Flutter Example',
      description: 'Web3Modal Flutter Example',
      url: 'https://www.walletconnect.com/',
      icons: ['https://walletconnect.com/walletconnect-logo.png'],
      redirect: Redirect(
        native: 'flutterdapp://',
        universal: 'https://www.walletconnect.com',
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _w3mService.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/certify.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ],
              ).afmPadding(
                EdgeInsets.only(top: 50.h),
              ),
              Text(
                "Giving Physical Products\nA Digital Identity",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Int',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {});
                },
                child: W3MConnectWalletButton(
                  service: _w3mService,
                  // custom: CustomButton(
                  //   pageCTA: 'Get Certified - Sign Up',
                  //   buttonOnPressed: () {},
                  // ).afmPadding(
                  //   EdgeInsets.only(bottom: 10.h),
                  // ),
                ),
              ),
              // : W3MAccountButton(
              //     service: _w3mService,
              //     size: BaseButtonSize.regular,
              //     custom: CustomW3MButton(service: _w3mService),
              //   ).afmPadding(
              //     EdgeInsets.only(bottom: 10.h),
              //   ),
              Builder(builder: (context) {
                return _w3mService.isConnected == false
                    ? CustomButton(
                        pageCTA: 'Log In',
                        color: Colors.deepPurple,
                        buttonTextColor: Colors.white,
                        buttonOnPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      ).afmPadding(
                        EdgeInsets.only(bottom: 20.h, right: 10.sp),
                      )
                    : const SizedBox();
              }),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      pageCTA: 'Be a guest',
                      color: Colors.deepPurple,
                      buttonTextColor: Colors.white,
                      buttonOnPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CertifiedHome(),
                          ),
                        );
                      },
                    ).afmPadding(
                      EdgeInsets.only(bottom: 20.h),
                    ),
                  ),
                ],
              ).afmPadding(
                EdgeInsets.symmetric(horizontal: 20.h),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
