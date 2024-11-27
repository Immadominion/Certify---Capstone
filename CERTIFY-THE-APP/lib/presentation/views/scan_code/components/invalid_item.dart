import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/all_certify_projects_controller.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:top_modal_sheet/top_modal_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/env_assets.dart';

Future<dynamic> invalidItem(BuildContext context) async {
  return showModalBottomSheet<String?>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 214.h,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              EnvAssets.getSvgPath('checkwrong-badge'),
            ).afmPadding(
              EdgeInsets.only(
                top: 40.h,
                bottom: 10.h,
              ),
            ),
            Text(
              "Not Recognised",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            CustomButton(
              pageCTA: "Go Back",
              height: 40.h,
              width: 150.w,
              buttonOnPressed: () {
                Navigator.pop(context);
              },
            ).afmBorderRadius(BorderRadius.circular(50.sp)).afmPadding(
                  EdgeInsets.only(
                    top: 15.h,
                    bottom: 40.h,
                  ),
                ),
          ],
        ),
      );
    },
  );
}

Future<dynamic> validItem(BuildContext context, WidgetRef ref) async {
  final data = ref.read(allCertifiedProjectsController).verifiedUrl;
  return showModalBottomSheet<String?>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 214.h,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              EnvAssets.getSvgPath('checkmark-badge'),
            ).afmPadding(
              EdgeInsets.only(
                top: 40.h,
                bottom: 10.h,
              ),
            ),
            Text(
              "C E R T I F I E D",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            CustomButton(
              pageCTA: "View More",
              height: 40.h,
              width: 150.w,
              buttonOnPressed: () async {
                // Open the URL in the browser
                final url = Uri.parse(data);
                if (await canLaunchUrl(url)) {
                  await launchUrl(
                    url,
                    mode: LaunchMode.externalApplication,
                  );
                } else {
                  throw 'Could not launch $data';
                }
              },
            ).afmBorderRadius(BorderRadius.circular(50.sp)).afmPadding(
                  EdgeInsets.only(
                    top: 15.h,
                    bottom: 40.h,
                  ),
                ),
          ],
        ),
      );
    },
  );
}
