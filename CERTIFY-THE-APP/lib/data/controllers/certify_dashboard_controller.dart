import 'package:certify/data/controllers/base_controller.dart';
import 'package:certify/data/controllers/certify_login_controller.dart';
import 'package:certify/data/local/secure_storage_service.dart';
import 'package:certify/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dashBoardControllerProvider = ChangeNotifierProvider<DashBoardController>(
  (ref) => DashBoardController(),
);

final SecureStorageService secureStorageService =
    SecureStorageService(secureStorage: const FlutterSecureStorage());

class DashBoardController extends BaseChangeNotifier {
  int page = 0;
  int get myPage => page;
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  String _userEmail = "";
  String get userEmail => _userEmail;
  // ignore: prefer_final_fields
  bool _deviceHasInternet = true;
  bool get checkDeviceInternet => _deviceHasInternet;

  Future<String> getName() async {
    String? name = await secureStorageService.read(key: "name");
    List<String> part = name.toString().split(" ");
    name = part[0];
    return name;
  }

  Future<String> getImage() async {
    String? picture = await secureStorageService.read(key: "picture");
    return picture as String;
  }

  Future<String> getEmail() async {
    String? email = await secureStorageService.read(key: "email");
    String? tokenOx = await secureStorageService.read(key: "token");
    if (email == null || tokenOx == null) {
      _isLoggedIn = false;
      debugPrint('Email is null -- So user is Logged Out');
      debugPrint('Token is null -- So user is Logged Out');
      return '';
    } else if (email.isEmpty || tokenOx.isEmpty) {
      debugPrint('Token is empty -- So user is Logged Out');
      debugPrint('Email is empty -- So user is Logged Out');
      return '';
    } else {
      try {
        await locator<SecureStorageService>().write(
          key: 'loginMail',
          value: email,
        );
        _userEmail = await secureStorageService.read(key: 'loginMail') ?? '';
        Provider((ref) {
          ref.read(certifyLoginController);
        });
      } catch (e) {
        debugPrint('$e');
      }
      _isLoggedIn = true;
      _userEmail = email;
      return email;
    }
  }

  Future<bool> getKey(String key) async {
    String? stringn = await secureStorageService.read(key: key);
    if (stringn == null) {
      return false;
    } else if (stringn.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> getId() async {
    String? id = await secureStorageService.read(key: "id");
    return id as String;
  }

  void setPage(int num) {
    page = num;
    notifyListeners();
  }

  void setTwoPage() {
    page = 2;
    notifyListeners();
  }

  void switchPage(int index) {
    myPage = index;
  }

  set myPage(int index) {
    page = index;
    notifyListeners();
  }
}
