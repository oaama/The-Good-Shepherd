import 'package:flutter/material.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppTheme.navyBlue,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.08,
              child: Icon(Icons.church, size: 400, color: AppTheme.navyBlue),
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              color: AppTheme.cream,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person, size: 72, color: AppTheme.gold),
                    const SizedBox(height: 20),
                    Text(
                      'Your Profile',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: AppTheme.navyBlue,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 24),
                    _ProfileField(label: 'Full Name', value: 'John Doe'),
                    const SizedBox(height: 12),
                    _ProfileField(
                      label: 'Church Name',
                      value: 'St. Mark Church',
                    ),
                    const SizedBox(height: 12),
                    _ProfileField(label: 'Phone Number', value: '+20123456789'),
                    const SizedBox(height: 12),
                    _ProfileField(label: 'Area', value: 'Cairo'),
                    const SizedBox(height: 12),
                    _ProfileField(label: 'Email', value: 'john@example.com'),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.gold,
                        foregroundColor: AppTheme.navyBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text('Edit Profile'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppTheme.cream,
    );
  }
}

class _ProfileField extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.navyBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppTheme.navyBlue),
          ),
        ),
      ],
    );
  }
}
