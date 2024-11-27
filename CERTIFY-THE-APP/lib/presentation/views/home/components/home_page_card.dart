import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget homePageCard(
  String name,
  String title,
  BuildContext context,
  Widget route,
  bool forceReloadImage,
) {
  return Transform.translate(
    offset: const Offset(0, 0),
    child: InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        HapticFeedback.lightImpact();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return route;
            },
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(.15),
              blurRadius: 99,
            ),
          ],
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(),
            Container(
                height: 70.h,
                width: 70.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1.sp,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(50.r)),
                  // child: CachedNetworkImage(
                  //     key: ValueKey(forceReloadImage),
                  //     imageUrl: name,
                  //     fit: BoxFit.fitHeight,
                  //     // width: double.maxFinite,
                  //     placeholder: (context, url) =>
                  //         const Center(child: TransparentLoadingScreen()),
                  //     errorWidget: (context, url, error) => const Icon(
                  //           Icons.error,
                  //           color: Colors.red,
                  //         )),
                  child: Image.asset(name),
                )),
            Text(
              title,
              maxLines: 4,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
                fontFamily: "Int",
                color: Colors.black.withOpacity(.5),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(),
          ],
        ),
      ),
    ),
  );
}
