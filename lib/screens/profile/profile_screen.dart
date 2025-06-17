import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; // Added Provider
import 'package:the_good_shepherd/theme/app_theme.dart';
// import 'package:the_good_shepherd/services/api_service.dart'; // Commented out ApiService
import 'package:the_good_shepherd/providers/user_provider.dart'; // Added UserProvider
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:the_good_shepherd/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // final ApiService _apiService = ApiService(); // Commented out ApiService
  // bool _isLoading = true; // Will use provider's isLoading
  bool _isEditing = false;
  User? _editingUser; // Local copy for editing state
  // String? _errorMessage; // Will use provider's error message

  @override
  void initState() {
    super.initState();
    // Fetch user profile using UserProvider after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserProfile();
    });
  }

  Future<void> _fetchUserProfile() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.fetchCurrentUser(); // Assuming this method exists and sets isLoading/error
    if (userProvider.currentUser != null) {
      setState(() {
        // Make a local copy for editing, assuming User has a copyWith or fromJson/toJson
        // For simplicity, direct assignment if User is mutable, or implement User.clone() / User.copyWith()
        // This example assumes direct assignment or a simple clone for editing state.
        // A robust solution would use a proper cloning method.
        _editingUser = User(
            id: userProvider.currentUser!.id,
            fullName: userProvider.currentUser!.fullName,
            email: userProvider.currentUser!.email,
            phoneNumber: userProvider.currentUser!.phoneNumber,
            churchName: userProvider.currentUser!.churchName,
            area: userProvider.currentUser!.area,
            createdAt: userProvider.currentUser!.createdAt);
      });
    }
  }

  Future<void> _updateProfile() async {
    if (_editingUser == null) return;

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    // No need to setState for isLoading = true, provider should handle its own loading state.

    bool success = await userProvider.updateUserProfile(_editingUser!); // Assuming this returns bool or throws

    if (success) {
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
    } else if (userProvider.error != null) {
      Fluttertoast.showToast(
        msg: userProvider.error!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        backgroundColor: AppTheme.errorColor,
        textColor: Colors.white,
      );
    }
    // No need for finally setState for isLoading, provider handles it.
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>(); // Watch for changes

    if (userProvider.isLoading && _editingUser == null) { // Show loading only if no user data yet
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

    if (userProvider.error != null && _editingUser == null) { // Show error only if no user data yet
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
          backgroundColor: AppTheme.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: Center(
          child: Text(
            userProvider.error!,
            style: TextStyle(
              color: AppTheme.errorColor,
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    // If not loading and no error, but editingUser is not set yet from provider, try to set it.
    // This can happen if fetchCurrentUser completes but widget hasn't rebuilt with new provider state yet.
    if (_editingUser == null && userProvider.currentUser != null) {
       _editingUser = User( // Direct assignment or clone
            id: userProvider.currentUser!.id,
            fullName: userProvider.currentUser!.fullName,
            email: userProvider.currentUser!.email,
            phoneNumber: userProvider.currentUser!.phoneNumber,
            churchName: userProvider.currentUser!.churchName,
            area: userProvider.currentUser!.area,
            createdAt: userProvider.currentUser!.createdAt);
    }


    if (_editingUser == null) { // If still no user data (e.g. provider has no user after fetch)
      return const Scaffold(
        appBar: AppBar(title: Text('My Profile')),
        body: Center(child: Text('No profile data available')),
      );
    }

    // At this point, _editingUser should be available for the UI
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
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 16.0), // Responsive padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Responsive Sized Box
            // Profile Picture
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.15, // Responsive radius
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.03), // Responsive Sized Box
            // User Info Card
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04), // Responsive padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProfileInfoRow('Name', _editingUser!.fullName, isEditable: true),
                    const Divider(),
                    _buildProfileInfoRow('Email', _editingUser!.email, isEditable: true),
                    const Divider(),
                    _buildProfileInfoRow('Phone', _editingUser!.phoneNumber, isEditable: true),
                    const Divider(),
                    _buildProfileInfoRow('Church', _editingUser!.churchName, isEditable: false),
                    const Divider(),
                    _buildProfileInfoRow('Region', _editingUser!.area, isEditable: false),
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
                    onTap: () {
                      Fluttertoast.showToast(msg: "Language selection tapped");
                    },
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02), // Responsive padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container( // Changed SizedBox to Container for more flexibility if needed
            width: screenWidth * 0.25, // Responsive width for label
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
                        if (label == 'Name') {
                          _editingUser!.fullName = newValue;
                        } else if (label == 'Email') {
                          _editingUser!.email = newValue;
                        } else if (label == 'Phone') {
                          _editingUser!.phoneNumber = newValue;
                        }
                      });
                    },
                  )
                : Text(
                    value, // Display from _editingUser which reflects provider or edits
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
