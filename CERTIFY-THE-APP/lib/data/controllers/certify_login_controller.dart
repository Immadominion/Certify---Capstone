import 'dart:convert';

import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/base_controller.dart';
import 'package:certify/data/services/certify_login_service.dart';
import 'package:certify/data/services/error_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/locator.dart';
import '../local/toast_service.dart';

final certifyLoginController =
    ChangeNotifierProvider<LoginController>((ref) => LoginController());

class LoginController extends BaseChangeNotifier {
  LoginService loginService = LoginService();

  Future<bool> signIn(String email, String password) async {
    loadingState = LoadingState.loading;
    notifyListeners();
    try {
      final res = await loginService.signIn(
        email: email,
        password: password,
      );
      if (res.statusCode == 200) {
        debugPrint("Login Success");
        locator<ToastService>().showErrorToast(
          "You are logged In",
        );
        Map<String, dynamic> jsonDataMap = json.decode(res.toString());
        // Extract the "token" value
        String token = jsonDataMap['token'];
        debugPrint("Token: $token");
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        final userInformation = await loginService.getUserInformation();

        debugPrint("ppf: $userInformation");

        if (userInformation.statusCode == 200) {
          Map<String, dynamic> userDataMap =
              json.decode(userInformation.toString());
          String name = userDataMap['name'];
          debugPrint("Name: $name");
          prefs.setString('name', name);
        }

        loadingState = LoadingState.idle;
        return true;
      } else {
        loadingState = LoadingState.idle;
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
    } catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
    }
    return false;
  }
}
