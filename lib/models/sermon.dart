import 'package:flutter/foundation.dart';

class Sermon {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String? audioUrl;

  Sermon({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.audioUrl,
  });

  factory Sermon.fromJson(Map<String, dynamic> json) => Sermon(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    date: DateTime.parse(json['date'] as String),
    audioUrl: json['audioUrl'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'date': date.toIso8601String(),
    if (audioUrl != null) 'audioUrl': audioUrl,
  };

  factory Sermon.dummy({
    required String id,
    required String title,
    required String description,
    required DateTime date,
    String? audioUrl,
  }) => Sermon(
    id: id,
    title: title,
    description: description,
    date: date,
    audioUrl: audioUrl,
  );
}
