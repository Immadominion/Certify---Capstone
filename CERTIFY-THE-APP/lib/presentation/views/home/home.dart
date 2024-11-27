import 'package:certify/data/controllers/all_certify_projects_controller.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/company/demo_page.dart';
import 'package:certify/presentation/views/home/components/home_page_card.dart';
import 'package:certify/presentation/views/scan_code/scan_code.dart';
import 'package:certify/presentation/views/shared_widgets/header_pad.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model_data/all_certified_projects_model.dart';

class CertifiedHome extends ConsumerStatefulWidget {
  const CertifiedHome({super.key});

  @override
  CertifiedHomeState createState() => CertifiedHomeState();
}

class CertifiedHomeState extends ConsumerState<CertifiedHome>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final listProjects = ref.read(allCertifiedProjectsController.notifier);

  List<String> dataList = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  Future<void> fetchData() async {
    // await listProjects.toGetAllCertifyProjects();
    Future.delayed(Durations.medium1);
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Consumer(
        builder: (context, ref, child) {
          // final LoadingState loadingState =
          //     ref.watch(allCertifiedProjectsController).loadingState;
          // final bool isLoading = loadingState == LoadingState.loading;
          return Stack(
            children: [
              /// ListView
              ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  const CertifyAppBar(),
                  RefreshIndicator(
                    onRefresh: () {
                      listProjects.shouldReload = true;
                      return fetchData();
                    },
                    child: SizedBox(
                      height: 535.h,
                      child: Stack(
                        children: [
                          FutureBuilder(
                            // future: ref
                            //     .read(allCertifiedProjectsController)
                            //     .toGetAllCertifyProjects(),/
                            future: Future.delayed(Durations.medium1),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const TransparentLoadingScreen();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return GridView.builder(
                                  padding: EdgeInsets.all(15.w),
                                  itemCount:
                                      certifiedProjects[0].results?.length,
                                  // listProjects
                                  //         .allCertifiedProjectsModel
                                  //         .results
                                  //         ?.length ??
                                  // 1,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 180.h,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10.h,
                                    crossAxisSpacing: 10.w,
                                  ),
                                  itemBuilder: ((context, index) {
                                    return
                                        // listProjects
                                        //             .allCertifiedProjectsModel
                                        //             .results
                                        //             ?.isEmpty ??
                                        //         false
                                        //     ? Center(
                                        //         child: Lottie.asset(
                                        //           "assets/animation/null-animation.json",
                                        //           controller: _controller,
                                        //           onLoaded: (composition) {
                                        //             _controller
                                        //               ..duration =
                                        //                   composition.duration
                                        //               ..repeat();
                                        //           },
                                        //         ),
                                        //       )
                                        //     :
                                        homePageCard(
                                      // listProjects.allCertifiedProjectsModel
                                      //         .results?[index].image
                                      //         ?.toString() ??
                                      //     "",
                                      certifiedProjects[0]
                                          .results![index]
                                          .image
                                          .toString(),
                                      certifiedProjects[0]
                                          .results![index]
                                          .name
                                          .toString(),
                                      // listProjects.allCertifiedProjectsModel
                                      //         .results?[index].name
                                      //         .toString() ??
                                      //     "",
                                      context,
                                      const DemoPage(),
                                      listProjects.shouldReload,
                                    );
                                  }),
                                );
                              } else {
                                return const Center(
                                  child: TransparentLoadingScreen(),
                                );
                              }
                            },
                          ),
                          // if (isLoading) const TransparentLoadingScreen(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

List<AllCertifiedProjectsModel> certifiedProjects = [
  AllCertifiedProjectsModel(
    results: [
      Results(
        id: 1,
        semifungible: false,
        mintAddress: "0x9adbcf1245ac1234efgh5678ijkl9012",
        status: "active",
        transferable: true,
        compressed: false,
        sellerFeeBasisPoints: 100,
        name: "Google LLC",
        symbol: "GOOGL",
        description:
            "Global technology company specializing in search engine, advertising, and software solutions.",
        image: "assets/images/google.png",
      ),
      Results(
        id: 2,
        semifungible: false,
        mintAddress: "0x2345abc3456def789ghi1234jkl4567",
        status: "active",
        transferable: true,
        compressed: false,
        sellerFeeBasisPoints: 250,
        name: "Amazon Inc.",
        symbol: "AMZN",
        description: "Leading e-commerce and cloud computing provider.",
        image: "assets/images/apple.png",
      ),
      Results(
        id: 3,
        semifungible: true,
        mintAddress: "0x7890qwe098rty123uv1234efghi56789",
        status: "active",
        transferable: false,
        compressed: true,
        sellerFeeBasisPoints: 150,
        name: "Tesla Motors",
        symbol: "TSLA",
        description:
            "Innovative automotive company specializing in electric vehicles.",
        image: "assets/images/tesla.png",
      ),
      Results(
        id: 5,
        semifungible: false,
        mintAddress: "0xab2345lmn678opq345rstuv567wxy890",
        status: "pending",
        transferable: true,
        compressed: true,
        sellerFeeBasisPoints: 350,
        name: "Microsoft Corporation",
        symbol: "MSFT",
        description:
            "Tech company specializing in software, cloud computing, and personal electronics.",
        image: "assets/images/microsoft.png",
      ),
      Results(
        id: 6,
        semifungible: true,
        mintAddress: "0x123qwe456asd789zxc890poi567qwe12",
        status: "pending",
        transferable: false,
        compressed: false,
        sellerFeeBasisPoints: 300,
        name: "Samsung Electronics",
        symbol: "SSNLF",
        description:
            "Major manufacturer of consumer electronics, home appliances, and mobile devices.",
        image: "assets/images/samsung.png",
      ),
      Results(
        id: 8,
        semifungible: false,
        mintAddress: "0x1poiuy098mnb456vfr567cde234rtyu",
        status: "inactive",
        transferable: true,
        compressed: true,
        sellerFeeBasisPoints: 175,
        name: "Nike Inc.",
        symbol: "NKE",
        description: "Leading athletic apparel and footwear company.",
        image: "assets/images/nike.png",
      ),
      Results(
        id: 10,
        semifungible: false,
        mintAddress: "0x1234wert5678zxcv6789plmnb098qaz",
        status: "pending",
        transferable: true,
        compressed: true,
        sellerFeeBasisPoints: 100,
        name: "Uber Technologies",
        symbol: "UBER",
        description: "Ride-hailing and transportation technology company.",
        image: "assets/images/uber.png",
      ),
    ],
    page: 1,
    limit: 10,
    totalPages: 1,
    totalResults: 10,
  ),
];
