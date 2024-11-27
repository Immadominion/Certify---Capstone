class AllManufacturerProjectsModel {
  final List<ProjectModel>? projects;

  AllManufacturerProjectsModel({
    this.projects,
  });

  factory AllManufacturerProjectsModel.fromJson(List<dynamic>? json) {
    return AllManufacturerProjectsModel(
      projects: json != null
          ? List<ProjectModel>.from(
              json.map((projectJson) => ProjectModel.fromJson(projectJson)),
            )
          : null,
    );
  }
}

class ProjectModel {
  final int? id;
  final String? status;
  final String? mintAddress;
  final bool? semifungible;
  final int? sellerFeeBasisPoints;
  final String? name;
  final String? symbol;
  final String? description;
  final String? image;
  final NftsModel? nfts;

  ProjectModel({
    this.id,
    this.status,
    this.mintAddress,
    this.semifungible,
    this.sellerFeeBasisPoints,
    this.name,
    this.symbol,
    this.description,
    this.image,
    this.nfts,
  });

  factory ProjectModel.fromJson(Map<String, dynamic>? json) {
    return ProjectModel(
      id: json?['id'],
      status: json?['status'],
      mintAddress: json?['mintAddress'],
      semifungible: json?['semifungible'],
      sellerFeeBasisPoints: json?['sellerFeeBasisPoints'],
      name: json?['name'],
      symbol: json?['symbol'],
      description: json?['description'],
      image: json?['image'],
      nfts: json?['nfts'] != null ? NftsModel.fromJson(json?['nfts']) : null,
    );
  }
}

class NftsModel {
  final List<dynamic>? results;
  final int? page;
  final int? limit;
  final int? totalPages;
  final int? totalResults;

  NftsModel({
    this.results,
    this.page,
    this.limit,
    this.totalPages,
    this.totalResults,
  });

  factory NftsModel.fromJson(Map<String, dynamic>? json) {
    return NftsModel(
      results: json?['results'],
      page: json?['page'],
      limit: json?['limit'],
      totalPages: json?['totalPages'],
      totalResults: json?['totalResults'],
    );
  }
}
