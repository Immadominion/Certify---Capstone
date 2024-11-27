import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class AllCertifiedServices with DioMixin {
  ///To get the user projects available and their corresponding ID
  Future<Response<dynamic>> getAllCertifiedProjects() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders)
        .get('', data: {"page": "1", "limit": "30"});
    return response;
  }

  ///To get the manufacturer nfts, after user has scanned a qrcode
  Future<Response<dynamic>> verifyNFT(String qrData) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders)
        .get('/verify-product', data: {"url": qrData});
    return response;
  }
}
