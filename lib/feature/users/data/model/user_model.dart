class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? imageUrl;
  final String? activity;
  final bool isActive;
  final bool isAdmin;
  final String role;
  final String? token;
  final String fullName;
  final DateTime addDate;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.imageUrl,
    this.activity,
    required this.isActive,
    required this.isAdmin,
    required this.role,
    this.token,
    required this.fullName,
    required this.addDate,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      imageUrl: json['imageUrl'] as String?,
      activity: json['activity'] as String?,
      isActive: json['isActive'] as bool,
      isAdmin: json['isAdmin'] as bool,
      role: json['role'] as String,
      token: json['token'] as String?,
      fullName: json['fullName'] as String,
      addDate: DateTime.parse(json['addDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'activity': activity,
      'isActive': isActive,
      'isAdmin': isAdmin,
      'role': role,
      'token': token,
      'fullName': fullName,
      'addDate': addDate.toIso8601String(),
    };
  }
}
