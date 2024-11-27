import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:certify/presentation/views/shared_widgets/header_pad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/controllers/certify_dashboard_controller.dart';
import '../../../data/local/toast_service.dart';
import '../../../utils/locator.dart';
import '../manufacturer_home/manufacturer_dashboard.dart';

class AccountInfoWidget extends StatefulWidget {
  const AccountInfoWidget({super.key});

  @override
  State<AccountInfoWidget> createState() => _AccountInfoWidgetState();
}

class _AccountInfoWidgetState extends State<AccountInfoWidget> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedName();
  }

  Future<void> _loadSavedName() async {
    final prefs = await SharedPreferences.getInstance();
    _nameController.text = prefs.getString('name') ?? '';
  }

  Future<void> _saveName(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', _nameController.text);
    locator<ToastService>().showErrorToast(
      "Name Updated Successfully!",
    );
    ref.read(dashBoardControllerProvider).setPage(0);

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const ManufacturerHome(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CertifyAppBar(
                text: 'Account Info',
              ),
              // Name Label
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    fontFamily: "Int",
                  ),
                ),
              ),
              // Name TextField
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Chukwuebuka',
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 1.5),
                  ),
                ),
              ),
              const Spacer(),
              // Update Info Button
              Consumer(builder: (context, ref, index) {
                return CustomButton(
                  pageCTA: "Update Info",
                  height: 45.h,
                  width: 300.w,
                  buttonOnPressed: () => _saveName(ref),
                );
              }),
              SizedBox(height: 30.h)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
