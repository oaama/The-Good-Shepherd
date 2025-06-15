// package:the_good_shepherd/models/panic_request.dart
class PanicRequest {
  final String id;
  final DateTime dateTime;
  final String userId;
  final String location;
  final String status;

  PanicRequest({
    required this.id,
    required this.dateTime,
    required this.userId,
    required this.location,
    required this.status,
  });
}
