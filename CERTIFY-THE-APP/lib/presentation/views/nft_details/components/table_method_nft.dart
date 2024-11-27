import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/presentation/views/project_details/components/table_row_on_pd.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Container tableContainerNFT(
    BuildContext context, WidgetRef ref, holdVal, showToast) {
  return Container(
    height: 80.h,
    width: MediaQuery.of(context).size.width - 20.sp,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        15.r,
      ),
      color: Theme.of(context).colorScheme.secondaryContainer,
    ),
    child: Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.intrinsicHeight,
      border: TableBorder(
        verticalInside: BorderSide(
          width: 1,
          color: Theme.of(context).colorScheme.primary,
          style: BorderStyle.solid,
        ),
      ),
      columnWidths: {0: FixedColumnWidth(50.w), 1: FixedColumnWidth(100.w)},
      children: [
        tableRowOnPd('Symbol', holdVal.symbol, context),
        // tableRowOnPd('Description', holdVal.description, context),
        tableRowOnPd(
          'Mint Address',
          ref.read(certifyProjectsController).mintAddress,
          context,
          copyText: true,
          onTap: () {
            Clipboard.setData(ClipboardData(
                text: ref.read(certifyProjectsController).mintAddress));

            showToast.showSuccessToast(
              'Successfully copied your mint address',
            );
          },
        ),
        tableRowOnPd(
          'Your Address',
          ref.read(certifyProjectsController).description,
          context,
          copyText: true,
          onTap: () {
            Clipboard.setData(ClipboardData(
                text: ref.read(certifyProjectsController).description));

            showToast.showSuccessToast(
              'Successfully copied your address',
            );
          },
        ),
      ],
    ).afmPadding(EdgeInsets.symmetric(horizontal: 5.sp, vertical: 13.h)),
  );
}
