class DailyVerse {
  final String id;
  final String reference;
  final String text;
  final DateTime date;

  DailyVerse({
    required this.id,
    required this.reference,
    required this.text,
    required this.date,
  });

  factory DailyVerse.fromJson(Map<String, dynamic> json) => DailyVerse(
    id: json['id'] as String,
    reference: json['reference'] as String,
    text: json['text'] as String,
    date: DateTime.parse(json['date'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'reference': reference,
    'text': text,
    'date': date.toIso8601String(),
  };

  factory DailyVerse.dummy({
    required String id,
    required String reference,
    required String text,
    required DateTime date,
  }) => DailyVerse(id: id, reference: reference, text: text, date: date);
}
