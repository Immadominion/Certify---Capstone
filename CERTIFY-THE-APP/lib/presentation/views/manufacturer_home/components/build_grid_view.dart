import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/data/model_data/all_manufacturer_projects_model.dart';
import 'package:certify/presentation/views/manufacturer_home/components/cards.dart';
import 'package:certify/presentation/views/manufacturer_home/components/update_list_projects.dart';
import 'package:certify/presentation/views/project_details/project_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

List<ProjectModel>? projects = [
  ProjectModel(
    id: 1,
    status: "active",
    mintAddress: "0x098aqw1234cfqe123rqwe23rqwf23r",
    semifungible: false,
    sellerFeeBasisPoints: 00,
    name: "Apple Inc.",
    symbol: "APL  ",
    description: "A multibillion dollar firm",
    image: "assets/images/apple.png",
    nfts: NftsModel(
      results: ["iPhones", "Airpods", "VR Headsets"],
      page: 1,
      limit: 10,
      totalPages: 2,
      totalResults: 15,
    ),
  ),
  ProjectModel(
    id: 2,
    status: "inactive",
    mintAddress: "MintAddress2",
    semifungible: true,
    sellerFeeBasisPoints: 300,
    name: "Beats by Dre",
    symbol: "BBD",
    description: "This is the second project.",
    image: "assets/images/beats.png",
    nfts: NftsModel(
      results: ["NFT4", "NFT5"],
      page: 1,
      limit: 5,
      totalPages: 1,
      totalResults: 5,
    ),
  ),
  ProjectModel(
    id: 3,
    status: "pending",
    mintAddress: "MintAddress3",
    semifungible: false,
    sellerFeeBasisPoints: 750,
    name: "Pepsi",
    symbol: "PPS",
    description: "This is the third project.",
    image: "assets/images/pepsi.jpeg",
    nfts: NftsModel(
      results: ["NFT6", "NFT7", "NFT8", "NFT9"],
      page: 2,
      limit: 4,
      totalPages: 2,
      totalResults: 8,
    ),
  ),
];
Widget buildGridView(
  WidgetRef ref,
  bool isLoading,
  controller,
) {
  // ref
  //     .watch(certifyProjectsController)
  //     .allManufacturerProjectsModel
  //     .projects;

  if (projects == null || projects!.isEmpty) {
    return Center(
      child: Lottie.asset(
        "assets/animation/null-animation.json",
        controller: controller,
        onLoaded: (composition) {
          controller
            ..duration = composition.duration
            ..repeat();
        },
      ),
    );
  }

  return GridView.builder(
    padding: EdgeInsets.all(15.w),
    itemCount: projects!.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisExtent: 180.h,
      crossAxisCount: 2,
      mainAxisSpacing: 10.h,
      crossAxisSpacing: 10.w,
    ),
    itemBuilder: (context, index) {
      final project = projects![index];
      // ref
      //     .watch(certifyProjectsController)
      //     .allManufacturerProjectsModel
      //     .projects?[index];
      return card(
        project.name ?? '',
        project.status ?? '',
        project.image ?? '',
        ProjectDetails(project.image ?? ""),
        context,
        () {
          debugPrint("Starting out action $index");
          updateListProjects(ref, project);
        },
      );
    },
  );
}
