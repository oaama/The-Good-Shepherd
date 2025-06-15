// package:the_good_shepherd/models/user.dart
class User {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final int age;
  final String gender;
  final String? imageUrl;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.age,
    required this.gender,
    this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'] ?? '',
    fullName: json['fullName'] ?? '',
    email: json['email'] ?? '',
    phone: json['phone'] ?? '',
    age: json['age'] ?? 0,
    gender: json['gender'] ?? '',
    imageUrl: json['imageUrl'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullName': fullName,
    'email': email,
    'phone': phone,
    'age': age,
    'gender': gender,
    'imageUrl': imageUrl,
  };
}
