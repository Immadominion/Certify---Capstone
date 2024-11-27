 import 'package:certify/presentation/views/project_details/components/image_icon_on_pd.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AnimatedPositioned iconAnimation(BuildContext context, Function() onTap, isIconVisible) {
    return AnimatedPositioned(
      top: 35.h,
      left: isIconVisible ? 10.w : -kToolbarHeight,
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          onTap();
        },
        child: imageIcon(context),
      ),
    );
  }