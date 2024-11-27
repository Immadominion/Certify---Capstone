import 'package:certify/core/constants/enum.dart';
import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/data/local/local.dart';
import 'package:certify/data/local/toast_service.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/create/create_nft.dart';
import 'package:certify/presentation/views/manufacturer_home/components/my_fade_route.dart';
import 'package:certify/presentation/views/project_details/components/icon_animation.dart';
import 'package:certify/presentation/views/project_details/components/image_view_on_pd.dart';
import 'package:certify/presentation/views/project_details/components/table_method.dart';
import 'package:certify/presentation/views/project_details/list_nfts_widget.dart';
import 'package:certify/presentation/views/shared_widgets/status_bar_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class ProjectDetails extends ConsumerStatefulWidget {
  final String imageUrl;
  const ProjectDetails(this.imageUrl, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends ConsumerState<ProjectDetails>
    with SingleTickerProviderStateMixin {
  late final ScrollController myScrollController;
  late final holdVal = ref.read(certifyProjectsController);
  late ToastService showToast;
  bool _isIconVisible = true;
  bool met = false;

  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    // Change the color of the status bar to blue
    showToast = ToastService();
    setStatusBarColor(const Color(0xff5C71F3));
    myScrollController = ScrollController();
    myScrollController.addListener(_onScroll);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    Future.delayed(Duration.zero, () {
      fetchData();
    });
  }

  @override
  void dispose() {
    resetStatusBarColor();
    myScrollController.removeListener(_onScroll);
    myScrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    final isScrollingDown = myScrollController.position.userScrollDirection ==
        ScrollDirection.forward;
    _isIconVisible = isScrollingDown;
  }

  Future<void> fetchData() async {
    // final listProjects = ref.read(certifyProjectsController);
    // await ref
    //     .read(certifyProjectsController)
    //     .toGetAllManufacturerProjectsNFTs();
    Future.delayed(Durations.medium1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          late LoadingState loadingState =
              ref.watch(certifyProjectsController).loadingState;
          late bool isLoading = loadingState == LoadingState.loading;
          var nfts = ref
              .watch(certifyProjectsController)
              .allManufacturerProjectsNFTSModel
              .nfts;
          var reload = ref.read(certifyProjectsController).shouldReload;
          return Stack(
            children: [
              RefreshIndicator(
                  key: ValueKey(reload),
                  onRefresh: () {
                    reload = true;
                    return fetchData();
                  },
                  child: FutureBuilder(
                    future: Future.value(),
                    builder: ((context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView(
                          controller: myScrollController,
                          children: [
                            imageViewer(ref),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  holdVal.projectName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                CustomButton(
                                  pageCTA: 'Create Nfts',
                                  width: 90.w,
                                  height: 25.h,
                                  buttonOnPressed: () {
                                    // Navigate out of the ManufacturerHome dashboard

                                    Navigator.of(context).push(MyFadeRoute(
                                        route: const CreateSingleNft()));
                                  },
                                ),
                              ],
                            ).afmPadding(),
                            tableContainer(context, ref, holdVal, showToast)
                                .afmPadding(),
                            (nfts == null || nfts.results!.isEmpty)
                                ? Column(
                                    children: [
                                      Center(
                                        child: Lottie.asset(
                                          "assets/animation/null-animation.json",
                                          controller: _controller,
                                          onLoaded: (composition) {
                                            _controller
                                              ..duration = composition.duration
                                              ..repeat();
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 100.h,
                                      )
                                    ],
                                  )
                                : listOfNfts(ref).afmPadding(),
                          ],
                        );
                      } else {
                        return const TransparentLoadingScreen();
                      }
                    }),
                  )),
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
            ],
          );
        },
      ),
    );
  }
}
