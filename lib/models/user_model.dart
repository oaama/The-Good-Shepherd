class UserModel {
  final String id;
  final String fullName;
  final String churchName;
  final String phoneNumber;
  final String area;
  final DateTime createdAt;

  const UserModel({
    required this.id,
    required this.fullName,
    required this.churchName,
    required this.phoneNumber,
    required this.area,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      churchName: json['churchName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      area: json['area'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'churchName': churchName,
      'phoneNumber': phoneNumber,
      'area': area,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
