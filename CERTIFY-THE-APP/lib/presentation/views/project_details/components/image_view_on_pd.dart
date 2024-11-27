import 'package:certify/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Container imageViewer(WidgetRef ref) {
  return Container(
    width: double.maxFinite,
    height: 300.h,
    decoration: const BoxDecoration(
      color: Color(0xff5C71F3),
    ),
    alignment: Alignment.center,
    // child: Image.network(
    //   ref.read(certifyProjectsController).imageUrl,
    //   fit: BoxFit.fitHeight,
    //   width: double.maxFinite,
    //   height: 300.h,
    //   loadingBuilder: (
    //     BuildContext context,
    //     Widget child,
    //     ImageChunkEvent? loadingProgress,
    //   ) {
    //     if (loadingProgress == null) {
    //       // Image is fully loaded
    //       return child;
    //     } else {
    //       // Show a loading indicator or placeholder while the image is loading
    //       return Center(
    //         child: CircularProgressIndicator(
    //           value: loadingProgress.expectedTotalBytes != null
    //               ? loadingProgress.cumulativeBytesLoaded /
    //                   (loadingProgress.expectedTotalBytes ?? 1)
    //               : null,
    //         ),
    //       );
    //     }
    //   },
    //   errorBuilder: (BuildContext context, Object error,
    //       StackTrace? stackTrace) {
    //     // Show a fallback widget when the image fails to load
    //     return const Center(
    //       child: Icon(
    //         Icons.error,
    //         color: Colors.red,
    //       ),
    //     );
    //   },
    // ).afmBorderRadius(
    //   BorderRadius.only(
    //     topRight: Radius.circular(
    //       20.r,
    //     ),
    //     topLeft: Radius.circular(
    //       20.r,
    //     ),
    //   ),
    // ),
    child: Image.asset(
      "assets/images/certify.png",
      fit: BoxFit.fill,
    )
        .afmBorderRadius(BorderRadius.only(
            topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r)))
        .afmPadding(),
  );
}
