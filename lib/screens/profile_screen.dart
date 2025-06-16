import 'package:flutter/material.dart';
import 'package:the_good_shepherd/models/user.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // استخدم بيانات وهمية أو من المزود
    final user = User(
      id: '1',
      fullName: 'John Doe',
      churchName: 'St. Mark Church',
      phoneNumber: '0123456789',
      area: 'Cairo',
      createdAt: DateTime.now(),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.person, size: 48, color: AppTheme.lightGold),
                const SizedBox(height: 16),
                _profileRow('Full Name', user.fullName),
                _profileRow('Church Name', user.churchName),
                _profileRow('Phone Number', user.phoneNumber),
                _profileRow('Area', user.area),
                _profileRow('Created At', user.createdAt.toString()),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _profileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: const TextStyle(
              color: AppTheme.darkBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: AppTheme.darkBlue),
            ),
          ),
        ],
      ),
    );
  }
}
