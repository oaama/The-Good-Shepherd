import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  final String id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String location;
  final String status;
  final String? notes;
  final String? assignedPriest;

  Appointment({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.status,
    this.notes,
    this.assignedPriest,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);

  // Dummy data
  static Appointment dummy() => Appointment(
    id: '1',
    title: 'Confession with Father George',
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(hours: 1)),
    location: 'St. Mary Church',
    status: 'scheduled',
    assignedPriest: 'Father George',
  );
}
