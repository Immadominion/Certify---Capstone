// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class ScannedCodeModel {
  String? transactionId;
  int? nftId;
  int? projectId;

  ScannedCodeModel({this.transactionId, this.nftId, this.projectId});

  ScannedCodeModel.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'] as String;
    nftId = json['nftId'] as int;
    projectId = json['projectId'] as int;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.transactionId;
    data['nftId'] = this.nftId;
    data['projectId'] = this.projectId;
    return data;
  }
}
