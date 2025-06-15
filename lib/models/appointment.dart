// package:the_good_shepherd/models/appointment.dart
class Appointment {
  final String id;
  final String date;
  final String time;
  final String description;
  final String status;
  final String assignedPriest;

  Appointment({
    required this.id,
    required this.date,
    required this.time,
    required this.description,
    required this.status,
    required this.assignedPriest,
  });
}
