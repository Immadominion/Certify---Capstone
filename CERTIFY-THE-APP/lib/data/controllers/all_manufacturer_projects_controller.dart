import 'dart:async';

import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/base_controller.dart';
import 'package:certify/data/model_data/all_manufacturer_projects_model.dart';
import 'package:certify/data/model_data/single_nfts_detail_model.dart';
import 'package:certify/data/model_data/user_projects_nfts_model.dart';
import 'package:certify/data/services/certify_project_services.dart';
import 'package:certify/data/services/error_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final certifyProjectsController =
    ChangeNotifierProvider<AllManufacturerProjectsController>(
        (ref) => AllManufacturerProjectsController());

class AllManufacturerProjectsController extends BaseChangeNotifier {
  ProjectServices projectServices = ProjectServices();
  AllManufacturerProjectsModel allManufacturerProjectsModel =
      AllManufacturerProjectsModel();
  UserProjectsNftsModel allManufacturerProjectsNFTSModel =
      UserProjectsNftsModel();
  SingleNFTDetailsModel singleNFTDetailsModel = SingleNFTDetailsModel();
  bool _shouldReload = false;
  bool get shouldReload => _shouldReload;
  String _imageUrl = "";
  String get imageUrl => _imageUrl;
  String _projectName = "";
  String _projectId = "";
  String _nftId = "";
  String _symbol = "";
  String _description = "";
  String _mintAddress = "";
  String _sellerFreeBasisPoints = "";
  String get projectName => _projectName;
  String get projectId => _projectId;
  String get nftId => _nftId;
  String get symbol => _symbol;
  String get description => _description;
  String get mintAddress => _mintAddress;
  String get sellerFreeBasisPoints => _sellerFreeBasisPoints;

  set shouldReload(bool reload) {
    _shouldReload = reload;
    notifyListeners();
  }

  set imageUrl(String url) {
    _imageUrl = url;
    // debugPrint("Image Url Has Been Saved Successfully");
    notifyListeners();
  }

  set projectName(String projName) {
    _projectName = projName;
    // debugPrint("Project Name Has Been Saved Successfully");
    notifyListeners();
  }

  set projectId(String projId) {
    _projectId = projId;
    // debugPrint("Project ID Has Been Saved Successfully");
    notifyListeners();
  }

  set nftId(String nftId) {
    _nftId = nftId;
    // debugPrint("Project ID Has Been Saved Successfully");
    notifyListeners();
  }

  set symbol(String symbol) {
    _symbol = symbol;
    // debugPrint("Symbol Has Been Saved Successfully");
    notifyListeners();
  }

  set description(String desc) {
    _description = desc;
    // debugPrint("Desc Has Been Saved Successfully");
    notifyListeners();
  }

  set mintAddress(String mnA) {
    _mintAddress = mnA;
    // debugPrint("mint Address Has Been Saved Successfully");
    notifyListeners();
  }

  set sellerFreeBasisPoints(String sfbp) {
    _sellerFreeBasisPoints = sfbp;
    // debugPrint("Seller free remaining points Has Been Saved Successfully");
    notifyListeners();
  }

  void disposeAllManufacturerProjectsController() {
    allManufacturerProjectsModel = AllManufacturerProjectsModel();
  }

  Future<bool> toGetAllManufacturerProjects() async {
    if (shouldReload || allManufacturerProjectsModel.projects == null) {
      try {
        // loadingState = LoadingState.loading;
        debugPrint('shh To Get All Manufacturer Projects');
        final res = await projectServices.getProjects();
        debugPrint("Starting out operation on data");
        if (res.statusCode == 200) {
          debugPrint("INFO: Bearer shh ${res.data}");
          allManufacturerProjectsModel =
              AllManufacturerProjectsModel.fromJson(res.data);
          debugPrint("INFO: Done converting network data to dart model");
          // loadingState = LoadingState.idle;
          shouldReload = false;
          return true;
        } else {
          // loadingState = LoadingState.idle;
          debugPrint("Closing out operation");
          throw Error();
        }
      } on DioException catch (e) {
        // loadingState = LoadingState.idle;
        ErrorService.handleErrors(e);
        return false;
      } catch (e) {
        // loadingState = LoadingState.idle;
        ErrorService.handleErrors(e);
        return false;
      }
    }
    return true;
  }

  Future<bool> toGetAllManufacturerProjectsNFTs() async {
    debugPrint(
        "Value of nft model is ==> ${allManufacturerProjectsNFTSModel.toString()}");
    try {
      loadingState = LoadingState.loading;
      debugPrint('shh To Get All Manufacturer NFTs');
      final res =
          await projectServices.getAllManufacturersProjectsNFTs(projectId);
      debugPrint("Starting out operation on data");
      if (res.statusCode == 200) {
        debugPrint("INFO: Bearer shh ${res.data}");
        allManufacturerProjectsNFTSModel =
            UserProjectsNftsModel.fromMap(res.data);
        debugPrint("INFO: Done converting network data to dart nfts model");
        shouldReload = false;
        loadingState = LoadingState.idle;
        return true;
      } else {
        loadingState = LoadingState.idle;
        debugPrint("Closing out operation");
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
      return false;
    } catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
      return false;
    }
  }

  Future<bool> toGetAllManufacturerNFTsDetails() async {
    debugPrint("nft model is ==> ${singleNFTDetailsModel.toString()}");
    try {
      loadingState = LoadingState.loading;
      debugPrint('shh To Get All Manufacturer NFT Detail');
      // print("NFT ID >> $nftId PROJECTID >> $projectId");
      final res =
          await projectServices.getSingleManufacturersNft(projectId, nftId);
      debugPrint("Starting out operation on data");
      if (res.statusCode == 200) {
        // debugPrint("INFO: Bearer shh ${res.data}");
        singleNFTDetailsModel = SingleNFTDetailsModel.fromJson(res.data);
        debugPrint("INFO: Done converting network data to nfts specific model");
        shouldReload = false;
        loadingState = LoadingState.idle;
        return true;
      } else {
        loadingState = LoadingState.idle;
        debugPrint("Closing out operation");
        throw Error();
      }
    } on DioException catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
      return false;
    } catch (e) {
      loadingState = LoadingState.idle;
      ErrorService.handleErrors(e);
      return false;
    }
  }
}
