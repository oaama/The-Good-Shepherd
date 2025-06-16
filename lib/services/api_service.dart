import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'shared_prefs_service.dart';
import 'package:the_good_shepherd/models/sermon.dart';
import 'package:the_good_shepherd/models/daily_verse.dart';
import 'package:the_good_shepherd/models/daily_advice.dart';
import 'package:the_good_shepherd/models/user.dart';

/// ApiService handles all HTTP requests and token management.
class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.options.baseUrl = dotenv.env['API_URL'] ?? 'https://dummy-api.com';
    _dio.options.connectTimeout = const Duration(seconds: 10);
    _dio.options.receiveTimeout = const Duration(seconds: 10);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SharedPrefsService.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // TODO: Add global error handling
          return handler.next(e);
        },
      ),
    );
  }

  /// GET request
  Future<Response> get(String path, {Map<String, dynamic>? params}) async {
    try {
      return await _dio.get(path, queryParameters: params);
    } catch (e) {
      rethrow;
    }
  }

  /// POST request
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  /// PUT request
  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE request
  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } catch (e) {
      rethrow;
    }
  }

  // User-related methods with dummy data
  Future<User> login(String phone, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    return User(
      id: '1',
      fullName: 'Angelo Rezq',
      email: 'angelo.rezq@example.com',
      phoneNumber: '01012345678',
      churchName: 'St. Mary Church',
      area: 'Minya',
      createdAt: DateTime.now(),
    );
  }

  Future<User> getUserProfile() async {
    await Future.delayed(const Duration(seconds: 1));
    return User(
      id: '1',
      fullName: 'Angelo Rezq',
      email: 'angelo.rezq@example.com',
      phoneNumber: '01012345678',
      churchName: 'St. Mary Church',
      area: 'Minya',
      createdAt: DateTime.now(),
    );
  }

  Future<User> updateUserProfile(User updatedUser) async {
    await Future.delayed(const Duration(seconds: 1));
    return updatedUser;
  }

  // Sermon-related methods with dummy data
  Future<List<Sermon>> fetchSermons() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Sermon(
        id: '1',
        title: 'The Power of Faith',
        description: 'A sermon about faith and trust in God.',
        date: DateTime.now().subtract(const Duration(days: 1)),
        preacher: 'Father George',
        duration: '45:22',
        views: 1250,
        likes: 350,
      ),
      Sermon(
        id: '2',
        title: 'Love and Forgiveness',
        description: 'Learning to forgive as Christ forgave us.',
        date: DateTime.now().subtract(const Duration(days: 2)),
        preacher: 'Father Peter',
        duration: '38:15',
        views: 980,
        likes: 280,
      ),
      Sermon(
        id: '3',
        title: 'Prayer and Meditation',
        description: 'Guidance on how to pray effectively.',
        date: DateTime.now().subtract(const Duration(days: 3)),
        preacher: 'Father Mark',
        duration: '52:45',
        views: 1500,
        likes: 420,
      ),
    ];
  }

  // Daily content methods with dummy data
  Future<DailyVerse> fetchDailyVerse() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return DailyVerse(
      id: '1',
      reference: 'John 3:16',
      text: 'For God so loved the world that he gave his one and only Son, that whoever believes in him shall not perish but have eternal life.',
      date: DateTime.now(),
      likes: 125,
      shares: 45,
    );
  }

  Future<DailyAdvice> fetchDailyAdvice() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return DailyAdvice(
      id: '1',
      advice: 'Pray with a sincere heart today. Remember that God hears your prayers and is always with you.',
      date: DateTime.now(),
      category: 'Spiritual Growth',
      likes: 85,
    );
  }

  // Appointments methods with dummy data
  Future<List<Appointment>> fetchAppointments() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      Appointment(
        id: '1',
        title: 'Confession with Father George',
        startDate: DateTime.now().add(const Duration(days: 2)),
        endDate: DateTime.now().add(const Duration(days: 2, hours: 1)),
        location: 'St. Mary Church',
        status: 'scheduled',
      ),
      Appointment(
        id: '2',
        title: 'Bible Study',
        startDate: DateTime.now().add(const Duration(days: 3)),
        endDate: DateTime.now().add(const Duration(days: 3, hours: 2)),
        location: 'Church Hall',
        status: 'confirmed',
      ),
    ];
  }

  // Announcements methods with dummy data
  Future<List<Announcement>> fetchAnnouncements() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      Announcement(
        id: '1',
        title: 'Easter Service Schedule',
        content: 'The Easter service will be held at 9:00 AM on Sunday. Please arrive early for seating.',
        date: DateTime.now(),
        category: 'Church Events',
      ),
      Announcement(
        id: '2',
        title: 'Bible Study Group',
        content: 'New Bible study group starts next week. Join us every Wednesday at 7:00 PM.',
        date: DateTime.now(),
        category: 'Study Groups',
      ),
    ];
  }
}
