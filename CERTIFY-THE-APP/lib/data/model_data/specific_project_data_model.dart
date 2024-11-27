import 'dart:convert';

class SpecificProjectDataModel {
  int? id;
  String? status;
  String? mintAddress;
  bool? semifungible;
  int? sellerFeeBasisPoints;
  String? name;
  String? symbol;
  String? image;
  Nfts? nfts;

  SpecificProjectDataModel({
    this.id,
    this.status,
    this.mintAddress,
    this.semifungible,
    this.sellerFeeBasisPoints,
    this.name,
    this.symbol,
    this.image,
    this.nfts,
  });

  SpecificProjectDataModel copyWith({
    int? id,
    String? status,
    String? mintAddress,
    bool? semifungible,
    int? sellerFeeBasisPoints,
    String? name,
    String? symbol,
    String? image,
    Nfts? nfts,
  }) =>
      SpecificProjectDataModel(
        id: id ?? this.id,
        status: status ?? this.status,
        mintAddress: mintAddress ?? this.mintAddress,
        semifungible: semifungible ?? this.semifungible,
        sellerFeeBasisPoints: sellerFeeBasisPoints ?? this.sellerFeeBasisPoints,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        image: image ?? this.image,
        nfts: nfts ?? this.nfts,
      );

  factory SpecificProjectDataModel.fromJson(String str) =>
      SpecificProjectDataModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SpecificProjectDataModel.fromMap(Map<String, dynamic> json) =>
      SpecificProjectDataModel(
        id: json["id"],
        status: json["status"],
        mintAddress: json["mintAddress"],
        semifungible: json["semifungible"],
        sellerFeeBasisPoints: json["sellerFeeBasisPoints"],
        name: json["name"],
        symbol: json["symbol"],
        image: json["image"],
        nfts: json["nfts"] == null ? null : Nfts.fromMap(json["nfts"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "mintAddress": mintAddress,
        "semifungible": semifungible,
        "sellerFeeBasisPoints": sellerFeeBasisPoints,
        "name": name,
        "symbol": symbol,
        "image": image,
        "nfts": nfts?.toMap(),
      };
}

class Nfts {
  List<Result>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  Nfts({
    this.results,
    this.page,
    this.limit,
    this.totalPages,
    this.totalResults,
  });

  Nfts copyWith({
    List<Result>? results,
    int? page,
    int? limit,
    int? totalPages,
    int? totalResults,
  }) =>
      Nfts(
        results: results ?? this.results,
        page: page ?? this.page,
        limit: limit ?? this.limit,
        totalPages: totalPages ?? this.totalPages,
        totalResults: totalResults ?? this.totalResults,
      );

  factory Nfts.fromJson(String str) => Nfts.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Nfts.fromMap(Map<String, dynamic> json) => Nfts(
        results: json["results"] == null
            ? []
            : List<Result>.from(json["results"]!.map((x) => Result.fromMap(x))),
        page: json["page"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        totalResults: json["totalResults"],
      );

  Map<String, dynamic> toMap() => {
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toMap())),
        "page": page,
        "limit": limit,
        "totalPages": totalPages,
        "totalResults": totalResults,
      };
}

class Result {
  int? id;
  String? status;
  int? projectId;
  String? mintAddress;
  String? ownerAddress;
  String? name;
  String? symbol;
  String? image;

  Result({
    this.id,
    this.status,
    this.projectId,
    this.mintAddress,
    this.ownerAddress,
    this.name,
    this.symbol,
    this.image,
  });

  Result copyWith({
    int? id,
    String? status,
    int? projectId,
    String? mintAddress,
    String? ownerAddress,
    String? name,
    String? symbol,
    String? image,
  }) =>
      Result(
        id: id ?? this.id,
        status: status ?? this.status,
        projectId: projectId ?? this.projectId,
        mintAddress: mintAddress ?? this.mintAddress,
        ownerAddress: ownerAddress ?? this.ownerAddress,
        name: name ?? this.name,
        symbol: symbol ?? this.symbol,
        image: image ?? this.image,
      );

  factory Result.fromJson(String str) => Result.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Result.fromMap(Map<String, dynamic> json) => Result(
        id: json["id"],
        status: json["status"],
        projectId: json["projectId"],
        mintAddress: json["mintAddress"],
        ownerAddress: json["ownerAddress"],
        name: json["name"],
        symbol: json["symbol"],
        image: json["image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "status": status,
        "projectId": projectId,
        "mintAddress": mintAddress,
        "ownerAddress": ownerAddress,
        "name": name,
        "symbol": symbol,
        "image": image,
      };
}
