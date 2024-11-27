import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:certify/core/constants/enum.dart';
import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/all_certify_projects_controller.dart';
import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/data/controllers/create_project_controller.dart';
import 'package:certify/presentation/general_components/auth_component_1.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/shared_widgets/header_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateNewProject extends ConsumerStatefulWidget {
  const CreateNewProject({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateProductState();
}

class _CreateProductState extends ConsumerState<CreateNewProject> {
  late TextEditingController nameController;
  late TextEditingController shortNameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    shortNameController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    shortNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final LoadingState loadingState =
            ref.read(createProjectController).loadingState;
        final bool isLoading = loadingState == LoadingState.loading;
        return Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                CertifyAppBar(),
                SizedBox(
                  height: 535.h,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onTap: () {
                              ref.read(createProjectController).pickImage();
                            },
                            child: Center(
                              child: Container(
                                height: 310.h,
                                width: 310.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(.2),
                                  border: Border.all(
                                    color: Theme.of(context)
                                        .primaryColor, // Change the border color as needed
                                    width: 1
                                        .sp, // Adjust the border width as needed
                                  ),
                                  borderRadius: BorderRadius.circular(15.r),
                                  shape: BoxShape.rectangle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.r),
                                  child: Image.file(
                                    File(
                                      ref
                                          .watch(createProjectController)
                                          .imagePath,
                                    ),
                                    fit: BoxFit.fitHeight,
                                    width: 300.w,
                                    height: 300.h,
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
                                        child: Icon(
                                          Icons.add_a_photo_rounded,
                                          size: 40.sp,
                                        ),
                                      );
                                    },
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
                                ),
                              ),
                            ),
                          ),
                          component1(
                            Icons.person,
                            'Name...',
                            false,
                            true,
                            context,
                            nameController,
                          ).afmPadding(
                            EdgeInsets.only(top: 10.h),
                          ),
                          component1(
                            Icons.abc,
                            'Abbreviation...',
                            false,
                            true,
                            context,
                            shortNameController,
                          ).afmPadding(
                            EdgeInsets.symmetric(vertical: 10.h),
                          ),
                          component1(
                            Icons.note,
                            'Description...',
                            false,
                            true,
                            context,
                            descriptionController,
                          ).afmPadding(
                            EdgeInsets.only(bottom: 10.h),
                          ),
                          SizedBox(
                            height: 35.h,
                            width: 200.w,
                            child: CustomButton(
                              buttonOnPressed: () {
                                ref
                                    .read(createProjectController)
                                    .toCreateProject(
                                      nameController.text,
                                      shortNameController.text,
                                      descriptionController.text,
                                    )
                                    .then((value) {
                                  if (value == true) {
                                    setState(() {
                                      ref
                                          .read(certifyProjectsController)
                                          .shouldReload = true;
                                      ref
                                          .read(allCertifiedProjectsController)
                                          .shouldReload = true;
                                    });
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
                                    ).show();
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
                                  }
                                });
                              },
                              pageCTA: 'Create Project',
                            ).afmBorderRadius(BorderRadius.circular(20.r)),
                          ).afmPadding(EdgeInsets.only(top: 10.h)),
                        ],
                      ),
                      if (isLoading) const TransparentLoadingScreen(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
