// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class QRDataModel {
  Nft? nft;

  QRDataModel({this.nft});

  QRDataModel.fromJson(Map<String, dynamic> json) {
    nft = json['nft'] != null ? new Nft.fromJson(json['nft']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nft != null) {
      data['nft'] = this.nft!.toJson();
    }
    return data;
  }
}

class Nft {
  int? id;
  String? mintAddress;
  String? status;
  String? ownerAddress;
  String? name;
  String? symbol;
  String? image;

  Nft(
      {this.id,
      this.mintAddress,
      this.status,
      this.ownerAddress,
      this.name,
      this.symbol,
      this.image});

  Nft.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mintAddress = json['mintAddress'];
    status = json['status'];
    ownerAddress = json['ownerAddress'];
    name = json['name'];
    symbol = json['symbol'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mintAddress'] = this.mintAddress;
    data['status'] = this.status;
    data['ownerAddress'] = this.ownerAddress;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['image'] = this.image;
    return data;
  }
}
