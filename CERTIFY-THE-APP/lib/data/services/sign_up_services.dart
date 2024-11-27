import 'package:dio/dio.dart' show Response;
import 'package:flutter/foundation.dart';

import 'dio_mixin.dart';

class SignupService with DioMixin {
  ///To log user in
  Future<Response<dynamic>> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    // Use the configured Dio instance from the mixin
    final response = await connect(customHeaders: customHeaders).post(
      '/signup',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    debugPrint('successfully signed user In ==> ${response.data}');
    return response;
  }
}
