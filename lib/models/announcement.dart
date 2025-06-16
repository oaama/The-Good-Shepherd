import 'package:json_annotation/json_annotation.dart';

part 'announcement.g.dart';

@JsonSerializable()
class Announcement {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String category;
  final String? imageUrl;
  final bool isImportant;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.category,
    this.imageUrl,
    this.isImportant = false,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => _$AnnouncementFromJson(json);
  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

  // Dummy data
  static Announcement dummy() => Announcement(
    id: '1',
    title: 'Easter Service Schedule',
    content: 'The Easter service will be held at 9:00 AM on Sunday. Please arrive early for seating.',
    date: DateTime.now(),
    category: 'Church Events',
    isImportant: true,
  );
}
