import 'package:dio/dio.dart';
import '../models/user.dart';
import 'api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  Future<User> login(String phone, String password) async {
    final response = await _apiClient.post('/auth/login', {
      'phone': phone,
      'password': password,
    });
    return User.fromJson(response.data['user']);
  }

  Future<User> register({
    required String fullName,
    required String churchName,
    required String phoneNumber,
    required String area,
    required String address,
    required String password,
  }) async {
    final response = await _apiClient.post('/auth/register', {
      'fullName': fullName,
      'churchName': churchName,
      'phoneNumber': phoneNumber,
      'area': area,
      'address': address,
      'password': password,
    });
    return User.fromJson(response.data['user']);
  }

  Future<void> logout() async {
    // If you have a logout endpoint, call it here
    // await _apiClient.post('/auth/logout', {});
  }
}
