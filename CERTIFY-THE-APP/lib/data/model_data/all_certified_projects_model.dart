// ignore_for_file: unnecessary_this, prefer_collection_literals, unnecessary_new

class AllCertifiedProjectsModel {
  List<Results>? results;
  int? page;
  int? limit;
  int? totalPages;
  int? totalResults;

  AllCertifiedProjectsModel(
      {this.results,
      this.page,
      this.limit,
      this.totalPages,
      this.totalResults});

  AllCertifiedProjectsModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(new Results.fromJson(v));
      });
    }
    page = json['page'];
    limit = json['limit'];
    totalPages = json['totalPages'];
    totalResults = json['totalResults'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    data['page'] = this.page;
    data['limit'] = this.limit;
    data['totalPages'] = this.totalPages;
    data['totalResults'] = this.totalResults;
    return data;
  }
}

class Results {
  int? id;
  bool? semifungible;
  String? mintAddress;
  String? status;
  bool? transferable;
  bool? compressed;
  int? sellerFeeBasisPoints;
  String? name;
  String? symbol;
  String? description;
  String? image;

  Results(
      {this.id,
      this.semifungible,
      this.mintAddress,
      this.status,
      this.transferable,
      this.compressed,
      this.sellerFeeBasisPoints,
      this.name,
      this.symbol,
      this.description,
      this.image});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    semifungible = json['semifungible'];
    mintAddress = json['mintAddress'];
    status = json['status'];
    transferable = json['transferable'];
    compressed = json['compressed'];
    sellerFeeBasisPoints = json['sellerFeeBasisPoints'];
    name = json['name'];
    symbol = json['symbol'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['semifungible'] = this.semifungible;
    data['mintAddress'] = this.mintAddress;
    data['status'] = this.status;
    data['transferable'] = this.transferable;
    data['compressed'] = this.compressed;
    data['sellerFeeBasisPoints'] = this.sellerFeeBasisPoints;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
