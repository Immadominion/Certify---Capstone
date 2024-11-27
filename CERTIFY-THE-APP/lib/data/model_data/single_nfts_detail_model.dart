class SingleNFTDetailsModel {
  final NftModel? nft;
  final QRModel? qr;

  SingleNFTDetailsModel({this.nft, this.qr});

  factory SingleNFTDetailsModel.fromJson(Map<String, dynamic> json) =>
      SingleNFTDetailsModel(
        nft: NftModel.fromJson(json['nft'] as Map<String, dynamic>),
        qr: QRModel.fromJson(json['qr'] as Map<String, dynamic>),
      );
}

class QRModel {
  final String? id;
  final String? link;

  QRModel({this.id, this.link});

  factory QRModel.fromJson(Map<String, dynamic> json) => QRModel(
        id: json["_id"] as String?,
        link: json["link"] as String?,
      );
}

class NftModel {
  final int? id;
  final String? mintAddress;
  final String? status;
  final String? ownerAddress;
  final String? name;
  final String? description;
  final String? image;

  NftModel({
    this.id,
    this.mintAddress,
    this.status,
    this.ownerAddress,
    this.name,
    this.description,
    this.image,
  });

  factory NftModel.fromJson(Map<String, dynamic> json) => NftModel(
        id: json['id'] as int?,
        mintAddress: json['mintAddress'] as String?,
        status: json['status'] as String?,
        ownerAddress: json['ownerAddress'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        image: json['image'] as String?,
      );
}
