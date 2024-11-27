 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildImageContainer(context, decodedBytes) {
    return Center(
      child: SizedBox(
        height: 250.h,
        width: 400.w,
        child: Container(
          width: 200.w,
          height: 200.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.memory(decodedBytes!),
              const Text(
                'Save || Share',
              ),
            ],
          ),
        ),
      ),
    );
  }