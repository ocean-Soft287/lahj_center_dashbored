import 'advertismintphoto.dart';

class Advertisement {
  final int id;
  final String name;
  final int groupId;
  final int serviceId;
  final int price;
  final int currencyId;
  final int governorateId;
  final String area;
  final String description;
  final String memberId;
  final String status;
  final String? deletionReason;
  final List<AdvertisementImage> advertisementImages;

  Advertisement({
    required this.id,
    required this.name,
    required this.groupId,
    required this.serviceId,
    required this.price,
    required this.currencyId,
    required this.governorateId,
    required this.area,
    required this.description,
    required this.memberId,
    required this.status,
    this.deletionReason,
    required this.advertisementImages,
  });

  factory Advertisement.fromJson(Map<String, dynamic> json) {
    return Advertisement(
      id: json['id'],
      name: json['name'],
      groupId: json['groupId'],
      serviceId: json['serviceId'],
      price: json['price'],
      currencyId: json['currencyId'],
      governorateId: json['governorateId'],
      area: json['area'],
      description: json['description'],
      memberId: json['memberId'],
      status: json['status'],
      deletionReason: json['deletionReason'],
      advertisementImages: (json['advertisementImages'] as List)
          .map((e) => AdvertisementImage.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'groupId': groupId,
      'serviceId': serviceId,
      'price': price,
      'currencyId': currencyId,
      'governorateId': governorateId,
      'area': area,
      'description': description,
      'memberId': memberId,
      'status': status,
      'deletionReason': deletionReason,
      'advertisementImages':
      advertisementImages.map((e) => e.toJson()).toList(),
    };
  }
}
