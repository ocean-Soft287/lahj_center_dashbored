class GroupDataNumbers {
  final int? groupId;
  final String groupName;
  final double totalPrice;

  GroupDataNumbers({
    required this.groupId,
    required this.groupName,
    required this.totalPrice,
  });

  factory GroupDataNumbers.fromJson(Map<String, dynamic> json) {
    return GroupDataNumbers(
      groupId: json['groupId'],
      groupName: json['groupName'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'groupName': groupName,
      'totalPrice': totalPrice,
    };
  }
}
