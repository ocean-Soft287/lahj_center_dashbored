class AdvertisementImage {
  final int id;
  final String imageName;

  AdvertisementImage({
    required this.id,
    required this.imageName,
  });

  factory AdvertisementImage.fromJson(Map<String, dynamic> json) {
    return AdvertisementImage(
      id: json['id'],
      imageName: json['imageName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageName': imageName,
    };
  }
}
