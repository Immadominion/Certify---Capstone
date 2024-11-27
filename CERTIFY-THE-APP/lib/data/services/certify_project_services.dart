import 'package:dio/dio.dart' show Response;

import 'dio_mixin.dart';

class ProjectServices with DioMixin {
  ///To get the user projects available and their corresponding ID
  Future<Response<dynamic>> getProjects() async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).get(
      '/project',
    );
    return response;
  }

  ///To get the user projects available and their corresponding ID
  Future<Response<dynamic>> getAllManufacturersProjectsNFTs(
      String projectID) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).get(
      '/nfts',
      data: {"project_id": projectID, "page": "1", "limit": "14"},
    );
    return response;
  }

  ///To get a specific nfts in a specific project
  Future<Response<dynamic>> getSingleManufacturersNft(
      String projectID, String nftID) async {
    final customHeaders = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    };
    final response = await connect(customHeaders: customHeaders).get(
      '/details',
      data: {
        "project_id": projectID,
        "nft_id": nftID,
      },
    );
    return response;
  }
}
