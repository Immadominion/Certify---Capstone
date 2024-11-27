import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:certify/core/constants/enum.dart';
import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/create_project_controller.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/manufacturer_home/components/build_grid_view.dart';
import 'package:certify/presentation/views/shared_widgets/header_pad.dart';
import 'package:certify/presentation/views/shared_widgets/status_bar_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/constants/env_assets.dart';
import '../../../data/model_data/all_manufacturer_projects_model.dart';

class CreateSingleNft extends ConsumerStatefulWidget {
  const CreateSingleNft({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateSingleNftState();
}

class _CreateSingleNftState extends ConsumerState<CreateSingleNft> {
  late final TextEditingController nameController;
  late final TextEditingController serialNoController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    resetStatusBarColor();
    nameController = TextEditingController();
    serialNoController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    serialNoController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> disposeData() async {
    // final listProjects = ref.read(certifyProjectsController);
    ref.read(createProjectController).dispose;
    // Update the dataList here based on the fetched data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.sp),
        child: Consumer(builder: (context, ref, child) {
          final LoadingState loadingState =
              ref.read(createProjectController).loadingState;
          final bool isLoading = loadingState == LoadingState.loading;
          return Stack(
            children: [
              ListView(
                children: [
                  const CertifyAppBar().afmPadding(
                    EdgeInsets.only(
                      bottom: 15.sp,
                    ),
                  ),
                  Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              ref.read(createProjectController).pickImage();
                            },
                            child: Center(
                              child: Container(
                                height: 250.h,
                                width: 300.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(.2),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 5.sp,
                                  ),
                                  borderRadius: BorderRadius.circular(15.r),
                                  shape: BoxShape.rectangle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(11.r),
                                  child: Image.file(
                                    File(
                                      ref
                                          .watch(createProjectController)
                                          .imagePath,
                                    ),
                                    fit: BoxFit.fitHeight,
                                    width: 300.w,
                                    height: 250.h,
                                    frameBuilder: (
                                      BuildContext context,
                                      Widget child,
                                      int? frame,
                                      bool wasSynchronouslyLoaded,
                                    ) {
                                      if (wasSynchronouslyLoaded ||
                                          frame != null) {
                                        // Image is fully loaded
                                        return child;
                                      } else {
                                        // Show a loading indicator or placeholder while the image is loading
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    },
                                    errorBuilder: (BuildContext context,
                                        Object error, StackTrace? stackTrace) {
                                      // Show a fallback widget when the image fails to load
                                      return Center(
                                        child: SvgPicture.asset(
                                          EnvAssets.getSvgPath('camera-01'),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ).afmPadding(
                            EdgeInsets.only(
                              bottom: 15.sp,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              'Name',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                                fontFamily: "Int",
                              ),
                            ),
                          ),
                          TextField(
                            controller: nameController,
                            decoration: InputDecoration(
                              hintText: 'Cyber Cab',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1.5),
                              ),
                            ),
                          ).afmPadding(
                            EdgeInsets.only(
                              bottom: 10.sp,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              'Serial No.',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                                fontFamily: "Int",
                              ),
                            ),
                          ),
                          TextField(
                            controller: serialNoController,
                            decoration: InputDecoration(
                              hintText: '98sd-asd2',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1.5),
                              ),
                            ),
                          ).afmPadding(
                            EdgeInsets.only(
                              bottom: 10.sp,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5.sp),
                            child: Text(
                              'Description',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                                fontFamily: "Int",
                              ),
                            ),
                          ),
                          TextField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              hintText: 'Tesla Cyber Truck but as a cab!',
                              hintStyle: TextStyle(color: Colors.grey[500]),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 1.5),
                              ),
                            ),
                          ).afmPadding(
                            EdgeInsets.only(
                              bottom: 20.sp,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Large Project? Create multiple nfts",
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ).afmPadding(),
                              CustomButton(
                                width: MediaQuery.of(context).size.width - 60.w,
                                buttonOnPressed: () {
                                  ref
                                      .read(createProjectController)
                                      .toCreateSingleProduct(
                                        nameController.text,
                                        serialNoController.text,
                                        descriptionController.text,
                                      )
                                      .then((value) {
                                    if (value == true) {
                                      // Decode JSON string to Map
                                      Map<String, dynamic> jsonMap =
                                          json.decode(ref
                                              .read(createProjectController)
                                              .jsonString);

                                      // Accessing individual values
                                      String transaction =
                                          jsonMap['transaction'];
                                      String nftUrl = jsonMap['nft'];
                                      String qrCodeDataURI =
                                          jsonMap['qrCodeDataURI'];
                                      Uint8List bytes = base64Decode(
                                          qrCodeDataURI.split(',').last);
                                      setState(() {});
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.scale,
                                        dialogType: DialogType.success,
                                        title: 'Successful',
                                        desc:
                                            'You have successfully created a project',
                                        btnOkOnPress: () {
                                          Navigator.pop(context);
                                        },
                                        body: Column(
                                          children: [
                                            const Text(
                                              "You Product has been C E R T I F I E D",
                                              style: TextStyle(
                                                fontFamily: 'Int',
                                              ),
                                            ),
                                            Container(
                                              width: 200,
                                              height: 200,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.white,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Image.memory(
                                                bytes,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ).show();
                                      Future.delayed(
                                        Duration.zero,
                                        () {
                                          disposeData();
                                        },
                                      );
                                    } else {
                                      setState(() {});
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.scale,
                                        dialogType: DialogType.error,
                                        title: 'Failed',
                                        desc:
                                            'Your project could not be created!',
                                        btnOkOnPress: () {
                                          Navigator.pop(context);
                                        },
                                      ).show();
                                      Future.delayed(
                                        Duration.zero,
                                        () {
                                          disposeData();
                                        },
                                      );
                                    }
                                  });
                                },
                                pageCTA: 'Register Product',
                              ).afmBorderRadius(BorderRadius.circular(20.r)),
                            ],
                          ),
                        ],
                      ),
                      if (isLoading)
                        const Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 2,
                          child: TransparentLoadingScreen(),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
