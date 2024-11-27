import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:certify/presentation/views/profile/logged_in_profile.dart';
import 'package:certify/presentation/views/shared_widgets/header_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoggedInAccountInfoWidget extends StatefulWidget {
  final String userName;
  final String userEmail;
  final String userIndustry;
  final String userRcNumber;

  const LoggedInAccountInfoWidget({
    super.key,
    required this.userName,
    required this.userEmail,
    required this.userIndustry,
    required this.userRcNumber,
  });

  @override
  State<LoggedInAccountInfoWidget> createState() =>
      _LoggedInAccountInfoWidgetState();
}

class _LoggedInAccountInfoWidgetState extends State<LoggedInAccountInfoWidget> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController industry = TextEditingController();
  TextEditingController rcNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CertifyAppBar(
                    text: 'Account Info',
                    bottomPadding: 20,
                  ),
                  EditableProfileAvatar()
                ],
              ),
              _buildLabel('Name'),
              _buildTextField(widget.userName, name),
              SizedBox(height: 10.h),
              _buildLabel('Email'),
              _buildTextField(widget.userEmail, email),
              SizedBox(height: 10.h),
              _buildLabel('Industry'),
              _buildTextField(widget.userIndustry, industry),
              SizedBox(height: 10.h),
              _buildLabel('RC Number'),
              _buildTextField(widget.userRcNumber, rcNumber),
              const Spacer(),
              CustomButton(
                pageCTA: "Update Info",
                height: 45.h,
                width: 300.w,
                buttonOnPressed: () {
                  // Add logic to update information
                },
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13.sp,
          color: Colors.grey,
          fontWeight: FontWeight.w500,
          fontFamily: "Int",
        ),
      ),
    );
  }

  Widget _buildTextField(
      String initialValue, TextEditingController controller) {
    return TextField(
      controller: controller,
      enabled: true, // Enable editing if needed
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontFamily: "Int",
      ),
      decoration: InputDecoration(
        hintText: initialValue,
        hintStyle: const TextStyle(
          color: Color.fromRGBO(51, 51, 51, 0.5),
          fontFamily: "Int",
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:  BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary, width: 1.5),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
      ),
    );
  }
}
