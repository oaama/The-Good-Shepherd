import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';
import 'package:the_good_shepherd/services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:the_good_shepherd/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  bool _isEditing = false;
  User? _user;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      setState(() => _isLoading = true);
      
      // Get user data from API
      _user = await _apiService.getUserProfile();
      
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load profile: ${e.toString()}';
      });
      Fluttertoast.showToast(
        msg: _errorMessage!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: AppTheme.errorColor,
        textColor: Colors.white,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _updateProfile() async {
    if (_user == null) return;

    try {
      setState(() => _isLoading = true);
      
      // Update user data
      _user = await _apiService.updateUserProfile(_user!);
      
      setState(() {
        _isEditing = false;
      });
      
      Fluttertoast.showToast(
        msg: 'Profile updated successfully',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: AppTheme.primaryColor,
        textColor: Colors.white,
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to update profile: ${e.toString()}';
      });
      Fluttertoast.showToast(
        msg: _errorMessage!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: AppTheme.errorColor,
        textColor: Colors.white,
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Text(
            _errorMessage!,
            style: TextStyle(
              color: AppTheme.errorColor,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    if (_user == null) {
      return const Scaffold(
        appBar: AppBar(title: Text('My Profile')),
        body: Center(child: Text('No profile data available')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.done : Icons.edit,
              color: Colors.white,
            ),
            onPressed: _isEditing ? _updateProfile : () => setState(() => _isEditing = true),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppTheme.primaryColor,
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(duration: 500.ms),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppTheme.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // User Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileInfoRow('Name', _user!.fullName, isEditable: true),
                    const Divider(),
                    _buildProfileInfoRow('Email', _user!.email, isEditable: true),
                    const Divider(),
                    _buildProfileInfoRow('Phone', _user!.phoneNumber, isEditable: true),
                    const Divider(),
                    _buildProfileInfoRow('Church', _user!.churchName, isEditable: false),
                    const Divider(),
                    _buildProfileInfoRow('Region', _user!.area, isEditable: false),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 600.ms),
            const SizedBox(height: 24),
            // Settings Section
            Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor,
              ),
            ).animate().fadeIn(duration: 700.ms),
            const SizedBox(height: 12),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Notifications'),
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                      activeColor: AppTheme.primaryColor,
                    ),
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.language),
                    title: const Text('Language'),
                    trailing: const Text('English'),
                    onTap: () {},
                  ),
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.red),
                    title: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                    onTap: () {
                      // Handle logout
                      context.go('/login');
                    },
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 800.ms),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoRow(String label, String value, {bool isEditable = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.secondaryTextColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _isEditing && isEditable
                ? TextFormField(
                    initialValue: value,
                    decoration: InputDecoration(
                      hintText: value,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        _userData![label.toLowerCase()] = newValue;
                      });
                    },
                  )
                : Text(
                    value,
                    style: TextStyle(
                      color: AppTheme.primaryTextColor,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
