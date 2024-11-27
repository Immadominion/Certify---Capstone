import 'package:cached_network_image/cached_network_image.dart';
import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/manufacturer_home/components/my_fade_route.dart';
import 'package:certify/presentation/views/nft_details/nft_barcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

SizedBox listOfNfts(WidgetRef ref) {
  return SizedBox(
    height: 210.h,
    child: Stack(
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ref
                  .read(certifyProjectsController)
                  .allManufacturerProjectsNFTSModel
                  .nfts
                  ?.results
                  ?.length ??
              1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisExtent: 60.h,
            crossAxisCount: 2,
            mainAxisSpacing: 10.h,
            crossAxisSpacing: 10.w,
          ),
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () {
                ref.read(certifyProjectsController).nftId = ref
                    .read(certifyProjectsController)
                    .allManufacturerProjectsNFTSModel
                    .nfts!
                    .results![index]
                    .id
                    .toString();

                ref.read(certifyProjectsController).projectName = ref
                        .read(certifyProjectsController)
                        .allManufacturerProjectsNFTSModel
                        .nfts
                        ?.results?[index]
                        .name ??
                    "Nothing here";
                ref.read(certifyProjectsController).mintAddress = ref
                        .read(certifyProjectsController)
                        .allManufacturerProjectsNFTSModel
                        .nfts
                        ?.results?[index]
                        .mintAddress ??
                    "Nothing here";
                ref.read(certifyProjectsController).description = ref
                        .read(certifyProjectsController)
                        .allManufacturerProjectsNFTSModel
                        .nfts
                        ?.results?[index]
                        .ownerAddress ??
                    "Nothing here";
                ref.read(certifyProjectsController).symbol = ref
                        .read(certifyProjectsController)
                        .allManufacturerProjectsNFTSModel
                        .nfts
                        ?.results?[index]
                        .symbol ??
                    "Nothing here";
                Navigator.of(context)
                    .push(MyFadeRoute(route: const ViewNFTsDetail()));
              },
              child: Container(
                height: 70.h,
                width: (MediaQuery.of(context).size.width - 20.sp) / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Theme.of(context).colorScheme.primary.withOpacity(.5),
                ),
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.r),
                          topLeft: Radius.circular(15.r),
                        ),
                        child: CachedNetworkImage(
                            key: ValueKey(ref
                                .read(certifyProjectsController)
                                .shouldReload),
                            imageUrl: ref
                                    .read(certifyProjectsController)
                                    .allManufacturerProjectsNFTSModel
                                    .nfts
                                    ?.results?[index]
                                    .image ??
                                "",
                            fit: BoxFit.fitHeight,
                            // width: double.maxFinite,
                            placeholder: (context, url) =>
                                const Center(child: TransparentLoadingScreen()),
                            errorWidget: (context, url, error) => const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                )),
                      ).afmPadding(EdgeInsets.only(right: 3.w)),
                    ),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ref
                                    .read(certifyProjectsController)
                                    .allManufacturerProjectsNFTSModel
                                    .nfts
                                    ?.results?[index]
                                    .name ??
                                "Nothing here",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ).afmPadding(
                              EdgeInsets.only(top: 4.sp, bottom: 2.sp)),
                          Text(
                            "Symbol: ${ref.read(certifyProjectsController).allManufacturerProjectsNFTSModel.nfts?.results?[index].symbol}",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Status: ${ref.read(certifyProjectsController).allManufacturerProjectsNFTSModel.nfts?.results?[index].status}",
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
        )
      ],
    ),
  );
}
