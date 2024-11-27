import 'package:certify/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TableRow tableRowOnPd(String leftText, String rightText, BuildContext context,
    {bool copyText = false, Function()? onTap}) {
  return TableRow(
    children: [
      TableCell(
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Align content to the left
          children: [
            Text(leftText),
          ],
        ),
      ),
      TableCell(
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Align content to the right
          children: [
            Container(
              padding: EdgeInsets.only(left: 7.w),
              width: 170.w,
              child: Text(
                rightText,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: copyText
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                  overflow: TextOverflow.ellipsis,
                ),
                softWrap: true,
              ),
            ),
            copyText
                ? GestureDetector(
                    onTap: onTap,
                    child: Icon(
                      Icons.copy,
                      size: 11.sp,
                    ),
                  ).afmPadding(
                    EdgeInsets.only(
                      left: 2.sp,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    ],
  );
}
