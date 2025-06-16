// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
  id: json['id'] as String,
  title: json['title'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  location: json['location'] as String,
  status: json['status'] as String,
  notes: json['notes'] as String?,
  assignedPriest: json['assignedPriest'] as String?,
);

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'location': instance.location,
      'status': instance.status,
      'notes': instance.notes,
      'assignedPriest': instance.assignedPriest,
    };
