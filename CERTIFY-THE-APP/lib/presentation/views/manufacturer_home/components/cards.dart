// ignore_for_file: deprecated_member_use

import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/presentation/views/manufacturer_home/components/my_fade_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget card(String title, String subtitle, String imageUrl, Widget route,
    context, Function()? saveUp) {
  double w = MediaQuery.of(context).size.width;
  return InkWell(
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    onTap: () {
      Navigator.of(context).push(MyFadeRoute(route: route));
      saveUp!();
    },
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.05), blurRadius: 50),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: w / 2.6,
            decoration: BoxDecoration(
              color: const Color(0xff5C71F3),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.r),
              ),
            ),
            alignment: Alignment.center,
            // child: CachedNetworkImage(
            //   imageUrl: imageUrl,
            //   fit: BoxFit.fitHeight,
            //   width: double.maxFinite,
            //   height: w / 2.6,
            //   placeholder: (context, url) =>
            //       const Center(child: CircularProgressIndicator()),
            //   errorWidget: (context, url, error) => const Icon(
            //     Icons.error,
            //     color: Colors.red,
            //   ),
            // ),
            child: Image.asset(
              imageUrl,
              fit: BoxFit.fill,
            )
                .afmBorderRadius(BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r)))
                .afmPadding(),
          ).afmBorderRadius(
            BorderRadius.only(
              topRight: Radius.circular(
                20.r,
              ),
              topLeft: Radius.circular(
                20.r,
              ),
            ),
          ),
          Container(
            height: w / 6,
            width: w / 2.36,
            padding: EdgeInsets.symmetric(horizontal: w / 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  textScaleFactor: 1.4,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.8),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Int",
                  ),
                ),
                Text(
                  subtitle,
                  textScaleFactor: 1,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    fontFamily: "Int",
                    color: Colors.black.withOpacity(.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
