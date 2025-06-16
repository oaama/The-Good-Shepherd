import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String churchName;
  final String area;
  final String? profilePicture;
  final DateTime createdAt;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.churchName,
    required this.area,
    this.profilePicture,
    required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  // Dummy user data
  static User dummy() => User(
    id: '1',
    fullName: 'Angelo Rezq',
    email: 'angelo.rezq@example.com',
    phoneNumber: '01012345678',
    churchName: 'St. Mary Church',
    area: 'Minya',
    createdAt: DateTime.now(),
  );
}
