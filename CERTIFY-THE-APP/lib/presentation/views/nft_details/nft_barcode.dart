import 'package:certify/core/constants/enum.dart';
import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/data/local/local.dart';
import 'package:certify/data/local/toast_service.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/nft_details/components/table_method_nft.dart';
import 'package:certify/presentation/views/nft_details/nft_view.dart';
import 'package:certify/presentation/views/project_details/components/icon_animation.dart';
import 'package:certify/presentation/views/project_details/components/image_view_on_pd.dart';
import 'package:certify/presentation/views/shared_widgets/status_bar_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ViewNFTsDetail extends ConsumerStatefulWidget {
  const ViewNFTsDetail({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewNFTsDetailState();
}

class _ViewNFTsDetailState extends ConsumerState<ViewNFTsDetail>
    with SingleTickerProviderStateMixin {
  late final ScrollController myScrollController;
  late final holdVal = ref.read(certifyProjectsController);
  bool _isIconVisible = true;
  late ToastService showToast;
  bool met = false;
  bool showQRCode = false;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    // Change the color of the status bar to blue
    showToast = ToastService();
    setStatusBarColor(const Color(0xff5C71F3));
    myScrollController = ScrollController();
    myScrollController.addListener(_onScroll);

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    Future.delayed(Duration.zero, () {
      fetchData();
    });
  }

  void _onScroll() {
    final isScrollingDown = myScrollController.position.userScrollDirection ==
        ScrollDirection.forward;
    _isIconVisible = isScrollingDown;
  }

  Future<void> fetchData() async {
    await ref.read(certifyProjectsController).toGetAllManufacturerNFTsDetails();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        late LoadingState loadingState =
            ref.watch(certifyProjectsController).loadingState;
        var reload = true;
        late bool isLoading = loadingState == LoadingState.loading;
        return Stack(
          children: [
            RefreshIndicator(
              key: ValueKey(reload),
              onRefresh: () {
                reload = true;
                return fetchData();
              },
              child: FutureBuilder(
                  future: Future.value().then((value) {
                    ref.read(certifyProjectsController).imageUrl = ref
                            .read(certifyProjectsController)
                            .singleNFTDetailsModel
                            .nft
                            ?.image ??
                        "";
                  }),
                  builder: (context, snapshot) {
                    return ListView(
                      children: [
                        imageViewer(ref),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              holdVal.projectName,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            CustomButton(
                              pageCTA: 'VIEW CODE',
                              width: 90.w,
                              height: 25.h,
                              buttonOnPressed: () {
                                // Navigate out of the ManufacturerHome dashboard
                                // Navigator.of(context)
                                //     .push(MyFadeRoute(route: const ViewNFT()));
                                showQRCode = true;
                                ref.read(certifyProjectsController).imageUrl =
                                    ref
                                        .read(certifyProjectsController)
                                        .singleNFTDetailsModel
                                        .qr!
                                        .link
                                        .toString();
                              },
                            ),
                          ],
                        ).afmPadding(),
                        tableContainerNFT(
                          context,
                          ref,
                          holdVal,
                          showToast,
                        ).afmPadding(),
                      ],
                    );
                  }),
            ),
            iconAnimation(
              context,
              () {
                HapticFeedback.lightImpact();
                myScrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
                Navigator.pop(context);
              },
              _isIconVisible,
            ),
            if (isLoading) const TransparentLoadingScreen(),
            if (showQRCode) const ViewNFT(),
          ],
        );
      }),
    );
  }
}
