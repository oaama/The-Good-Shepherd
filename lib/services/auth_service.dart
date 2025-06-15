import '../models/user.dart';

class AuthService {
  Future<User> login(String email, String password) async {
    // TODO: Implement real API call
    await Future.delayed(const Duration(seconds: 1));
    return User(
      fullName: "John Doe",
      age: 20,
      gender: "Male",
      phone: "1234567890",
      email: email,
    );
  }

  Future<User> register(User user, String password) async {
    // TODO: Implement real API call
    await Future.delayed(const Duration(seconds: 1));
    return user;
  }
}
