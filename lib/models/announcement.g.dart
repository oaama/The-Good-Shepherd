// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  date: DateTime.parse(json['date'] as String),
  category: json['category'] as String,
  imageUrl: json['imageUrl'] as String?,
  isImportant: json['isImportant'] as bool? ?? false,
);

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'date': instance.date.toIso8601String(),
      'category': instance.category,
      'imageUrl': instance.imageUrl,
      'isImportant': instance.isImportant,
    };
