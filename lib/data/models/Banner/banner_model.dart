class BannerModel {
  final int status;
  final List<BannerItem> banners;

  BannerModel({
    required this.status,
    required this.banners,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      status: json['status'],
      banners: List<BannerItem>.from(
          json['banners'].map((banner) => BannerItem.fromJson(banner))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'banners': List<dynamic>.from(banners.map((banner) => banner.toJson())),
    };
  }
}

class BannerItem {
  final int id;
  final String banners;
  final String link;

  BannerItem({
    required this.id,
    required this.banners,
    required this.link,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id'],
      banners: json['banners'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'banners': banners,
      'link': link,
    };
  }
}
