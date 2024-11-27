// import 'dart:typed_data';

// import 'package:certify/core/constants/enum.dart';
// import 'package:certify/core/constants/env_assets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:mobile_scanner/mobile_scanner.dart';

// import '../../../data/controllers/all_certify_projects_controller.dart';
// import '../../general_components/shared_loading.dart';
// import 'components/invalid_item.dart';
// import 'components/overlay_painter.dart';

// class CertifiedScanner extends ConsumerStatefulWidget {
//   const CertifiedScanner({super.key});

//   @override
//   ConsumerState<CertifiedScanner> createState() => _CertifiedScannerState();
// }

// class _CertifiedScannerState extends ConsumerState<CertifiedScanner>
//     with SingleTickerProviderStateMixin {
//   late MobileScannerController cameraController;
//   late AnimationController _animationController;
//   late Animation<double> _animation;
//   bool isCodeDetected = false;
//   late String imagePath;
//   final ImagePicker picker = ImagePicker();
//   late XFile? pickedFile;
//   late final List<Barcode> barcodes;
//   late final Uint8List? image;
//   late bool isCertified;
//   Future<bool> _pickImage() async {
//     pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Get the file path from the picked image
//       imagePath = pickedFile!.path;
//       debugPrint('Image Path: $imagePath');

//       // You can use imagePath as needed (e.g., display in an Image widget)
//       // Example:
//       // Image.file(File(imagePath));
//       return true;
//     } else {
//       debugPrint('No image selected.');
//       return false;
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     cameraController = MobileScannerController(
//       detectionSpeed: DetectionSpeed.noDuplicates,
//       returnImage: true,
//     );

//     _animationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..repeat(reverse: true);

//     _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     cameraController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final scanBoxWidth = 300.w;
//     final scanBoxHeight = 400.w;
//     final screenSize = MediaQuery.of(context).size;

//     return Scaffold(
//       body: Stack(
//         children: [
//           // Camera View
//           MobileScanner(
//             controller: cameraController,
//             onDetect: (capture) {
//               final barcodes = capture.barcodes;
//               image = capture.image;
//               if (barcodes.isNotEmpty) {
//                 setState(() {
//                   isCodeDetected = true;
//                   _animationController.stop();
//                 });

//                 for (final barcode in barcodes) {
//                   debugPrint('Barcode found! => ${barcode.rawValue}');
//                   try {
//                     if (barcode.rawValue == "") return;
//                     ref
//                         .read(allCertifiedProjectsController)
//                         .toGetQRData(barcode.rawValue!)
//                         .then((value) {
//                       if (value == true) {
//                         validItem(context, ref);
//                       } else {
//                         invalidItem(context);
//                       }
//                     });
//                     isCertified = true;
//                   } catch (e) {
//                     isCertified = false;
//                     invalidItem(context);
//                   }
//                 }
//               }
//             },
//           ),

//           // Custom overlay with transparent center
//           CustomPaint(
//             size: Size(screenSize.width, screenSize.height),
//             painter: OverlayPainter(
//               overlayColor: const Color(0xFF333333).withOpacity(.5),
//               scannerWidth: scanBoxWidth,
//               scannerHeight: scanBoxHeight,
//               borderRadius: 20.r,
//             ),
//           ),

//           // Scanner Frame with Corner Edges
//           Positioned(
//             top: 105.h,
//             left: 30.sp,
//             right: 30.sp,
//             child: SizedBox(
//               width: scanBoxWidth,
//               height: scanBoxHeight,
//               child: Stack(
//                 children: [
//                   // Scanner Frame Corners
//                   ...List.generate(4, (index) {
//                     final isTop = index < 2;
//                     final isLeft = index.isEven;
//                     return Positioned(
//                       top: isTop ? 0 : null,
//                       bottom: !isTop ? 0 : null,
//                       left: isLeft ? 0 : null,
//                       right: !isLeft ? 0 : null,
//                       child: Container(
//                         width: 80.w,
//                         height: 80.h,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                             topLeft:
//                                 Radius.circular(isTop && isLeft ? 20.r : 0),
//                             topRight:
//                                 Radius.circular(isTop && !isLeft ? 20.r : 0),
//                             bottomLeft:
//                                 Radius.circular(!isTop && isLeft ? 20.r : 0),
//                             bottomRight:
//                                 Radius.circular(!isTop && !isLeft ? 20.r : 0),
//                           ),
//                           border: Border(
//                             top: isTop
//                                 ? BorderSide(
//                                     color: const Color(0xFF8246F3), width: 4.sp)
//                                 : BorderSide.none,
//                             bottom: !isTop
//                                 ? BorderSide(
//                                     color: const Color(0xFF8246F3), width: 4.sp)
//                                 : BorderSide.none,
//                             left: isLeft
//                                 ? BorderSide(
//                                     color: const Color(0xFF8246F3), width: 4.sp)
//                                 : BorderSide.none,
//                             right: !isLeft
//                                 ? BorderSide(
//                                     color: const Color(0xFF8246F3), width: 4.sp)
//                                 : BorderSide.none,
//                           ),
//                         ),
//                       ),
//                     );
//                   }),

//                   // Animated Scanning Line
//                   AnimatedBuilder(
//                     animation: _animation,
//                     builder: (context, child) {
//                       return Positioned(
//                         top: _animation.value * scanBoxHeight,
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           height: 2.sp,
//                           decoration: BoxDecoration(
//                             gradient: LinearGradient(
//                               colors: [
//                                 Colors.transparent,
//                                 isCodeDetected ? Colors.green : Colors.red,
//                                 Colors.transparent,
//                               ],
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Back Button and Camera Switch
//           SafeArea(
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 28.sp, vertical: 20.sp),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Back Button
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: SvgPicture.asset(
//                       EnvAssets.getSvgPath('arrow-left-double'),
//                       color: Colors.white,
//                     ),
//                   ),

//                   const Spacer(),

//                   // Camera Switch Button
//                   Center(
//                     child: Container(
//                       width: 100.sp,
//                       height: 100.sp,
//                       margin: EdgeInsets.only(bottom: 40.sp),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.4),
//                         borderRadius: BorderRadius.circular(50.sp),
//                       ),
//                       child: IconButton(
//                         onPressed: () => cameraController.switchCamera(),
//                         icon: ValueListenableBuilder(
//                           valueListenable: cameraController.cameraFacingState,
//                           builder: (context, state, child) {
//                             return SvgPicture.asset(
//                               EnvAssets.getSvgPath('camera-01'),
//                               color: Colors.white,
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           (ref.watch(allCertifiedProjectsController).loadingState ==
//                   LoadingState.loading)
//               ? const TransparentLoadingScreen()
//               : const SizedBox()
//         ],
//       ),
//     );
//   }
// }

import 'dart:typed_data';

import 'package:certify/core/constants/enum.dart';
import 'package:certify/core/constants/env_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../data/controllers/all_certify_projects_controller.dart';
import '../../general_components/shared_loading.dart';
import 'components/invalid_item.dart';
import 'components/overlay_painter.dart';

class CertifiedScanner extends ConsumerStatefulWidget {
  const CertifiedScanner({super.key});

  @override
  ConsumerState<CertifiedScanner> createState() => _CertifiedScannerState();
}

class _CertifiedScannerState extends ConsumerState<CertifiedScanner>
    with SingleTickerProviderStateMixin {
  late MobileScannerController cameraController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isCodeDetected = false;
  late String imagePath;
  final ImagePicker picker = ImagePicker();
  late XFile? pickedFile;
  late final List<Barcode> barcodes;
  late final Uint8List? image;
  late bool isCertified;

  Future<bool> _pickImage() async {
    pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imagePath = pickedFile!.path;
      debugPrint('Image Path: $imagePath');
      return true;
    } else {
      debugPrint('No image selected.');
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    cameraController = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      returnImage: true,
    );

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    cameraController.dispose();
    super.dispose();
  }

  Future<void> _handleBarcodeDetection(Barcode barcode) async {
    setState(() {
      isCodeDetected = true;
      _animationController.stop();
    });

    final isValid = await ref
        .read(allCertifiedProjectsController)
        .toGetQRData(barcode.rawValue!);

    if (isValid) {
      await validItem(context, ref);
    } else {
      await invalidItem(context);
    }

    setState(() {
      isCodeDetected = false;
      _animationController.repeat(reverse: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final scanBoxWidth = 300.w;
    final scanBoxHeight = 400.w;
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Camera View
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) {
              if (isCodeDetected) return;

              final barcodes = capture.barcodes;
              image = capture.image;
              if (barcodes.isNotEmpty) {
                final barcode = barcodes.first;
                if (barcode.rawValue != null && barcode.rawValue!.isNotEmpty) {
                  _handleBarcodeDetection(barcode);
                }
              }
            },
          ),

          // Custom overlay with transparent center
          CustomPaint(
            size: Size(screenSize.width, screenSize.height),
            painter: OverlayPainter(
              overlayColor: const Color(0xFF333333).withOpacity(.5),
              scannerWidth: scanBoxWidth,
              scannerHeight: scanBoxHeight,
              borderRadius: 20.r,
            ),
          ),

          // Scanner Frame with Corner Edges
          Positioned(
            top: 105.h,
            left: 30.sp,
            right: 30.sp,
            child: SizedBox(
              width: scanBoxWidth,
              height: scanBoxHeight,
              child: Stack(
                children: [
                  // Scanner Frame Corners
                  ...List.generate(4, (index) {
                    final isTop = index < 2;
                    final isLeft = index.isEven;
                    return Positioned(
                      top: isTop ? 0 : null,
                      bottom: !isTop ? 0 : null,
                      left: isLeft ? 0 : null,
                      right: !isLeft ? 0 : null,
                      child: Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(isTop && isLeft ? 20.r : 0),
                            topRight:
                                Radius.circular(isTop && !isLeft ? 20.r : 0),
                            bottomLeft:
                                Radius.circular(!isTop && isLeft ? 20.r : 0),
                            bottomRight:
                                Radius.circular(!isTop && !isLeft ? 20.r : 0),
                          ),
                          border: Border(
                            top: isTop
                                ? BorderSide(
                                    color: const Color(0xFF8246F3), width: 4.sp)
                                : BorderSide.none,
                            bottom: !isTop
                                ? BorderSide(
                                    color: const Color(0xFF8246F3), width: 4.sp)
                                : BorderSide.none,
                            left: isLeft
                                ? BorderSide(
                                    color: const Color(0xFF8246F3), width: 4.sp)
                                : BorderSide.none,
                            right: !isLeft
                                ? BorderSide(
                                    color: const Color(0xFF8246F3), width: 4.sp)
                                : BorderSide.none,
                          ),
                        ),
                      ),
                    );
                  }),

                  // Animated Scanning Line
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Positioned(
                        top: _animation.value * scanBoxHeight,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2.sp,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                isCodeDetected ? Colors.green : Colors.red,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          // Back Button and Camera Switch
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.sp, vertical: 20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(
                      EnvAssets.getSvgPath('arrow-left-double'),
                      color: Colors.white,
                    ),
                  ),

                  const Spacer(),

                  // Camera Switch Button
                  Center(
                    child: Container(
                      width: 100.sp,
                      height: 100.sp,
                      margin: EdgeInsets.only(bottom: 40.sp),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(50.sp),
                      ),
                      child: IconButton(
                        onPressed: () => cameraController.switchCamera(),
                        icon: ValueListenableBuilder(
                          valueListenable: cameraController.cameraFacingState,
                          builder: (context, state, child) {
                            return SvgPicture.asset(
                              EnvAssets.getSvgPath('camera-01'),
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          (ref.watch(allCertifiedProjectsController).loadingState ==
                  LoadingState.loading)
              ? const TransparentLoadingScreen()
              : const SizedBox()
        ],
      ),
    );
  }
}
