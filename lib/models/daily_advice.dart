class DailyAdvice {
  final String id;
  final String advice;
  final DateTime date;

  DailyAdvice({required this.id, required this.advice, required this.date});

  factory DailyAdvice.fromJson(Map<String, dynamic> json) => DailyAdvice(
    id: json['id'] as String,
    advice: json['advice'] as String,
    date: DateTime.parse(json['date'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'advice': advice,
    'date': date.toIso8601String(),
  };

  factory DailyAdvice.dummy({
    required String id,
    required String advice,
    required DateTime date,
  }) => DailyAdvice(id: id, advice: advice, date: date);
}
