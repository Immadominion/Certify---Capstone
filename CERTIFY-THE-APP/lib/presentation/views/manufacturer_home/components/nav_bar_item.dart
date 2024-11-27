import 'package:certify/data/controllers/certify_dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BottomNavigationBarItem buildBottomNavigationBarItem(
  WidgetRef ref,
  BuildContext context, {
  required String iconPath,
  required String label,
  required int index,
}) {
  final dashboardController = ref.watch(dashBoardControllerProvider);
  final selectedPageIndex = dashboardController.page;

  return BottomNavigationBarItem(
    icon: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // SvgPicture.asset(
        //   EnvAssets.getSvgPath(iconPath),
        //   width: 23.w,
        //   height: 23.h,
        //   // ignore: deprecated_member_use
        //   color: selectedPageIndex == index
        //       ? Theme.of(context).colorScheme.primary
        //       : Theme.of(context).unselectedWidgetColor,
        //   semanticsLabel: label,
        // ),
        SizedBox(
          height: 5.h,
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontFamily: "Int",
            color: selectedPageIndex == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ],
    ),
    label: '',
  );
}
