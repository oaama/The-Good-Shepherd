import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';
import 'package:flutter_animate/flutter_animate.dart'; // Added import

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy user data and stats
    const String userName = "John Doe";
    const int families = 42;
    const int parents = 7;
    const int sermons = 12;
    const int advices = 5;

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ListView(
          children: [
            Text(
              'Welcome, $userName!',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppTheme.churchBlue, // Updated
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              color: AppTheme.churchBlue.withOpacity(0.05), // Updated for a subtle blue tint
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatColumn(label: 'Families', value: families),
                    _StatColumn(label: 'Parents', value: parents),
                    _StatColumn(label: 'Sermons', value: sermons),
                    _StatColumn(label: 'Advices', value: advices),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _DashboardButton(
                  icon: Icons.person,
                  label: 'Profile',
                  onTap: () => context.go('/profile'),
                ),
                _DashboardButton(
                  icon: Icons.warning_amber_rounded,
                  label: 'Panic',
                  onTap: () => context.go('/panic'),
                ),
                _DashboardButton(
                  icon: Icons.family_restroom,
                  label: 'Parents',
                  onTap: () => context.go('/spiritual-fathers'),
                ),
                _DashboardButton(
                  icon: Icons.menu_book,
                  label: 'Priest Content',
                  onTap: () => context.go('/parent-content'),
                ),
              ].asMap().entries.map((entry) { // Added .asMap().entries.map for index
                int index = entry.key;
                Widget button = entry.value;
                return Animate( // Wrap each button
                  effects: [
                    FadeEffect(delay: (index * 150).ms, duration: 500.ms), // Staggered fade
                    ScaleEffect(delay: (index * 150).ms, duration: 500.ms, begin: const Offset(0.8, 0.8), end: const Offset(1,1)) // Staggered scale
                  ],
                  child: button,
                );
              }).toList(),
            ),
          ],
        ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.2, end: 0), // Animate the whole ListView
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final int value;
  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value',
          style: TextStyle(
            color: AppTheme.churchBlue, // Updated
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        Text(label, style: TextStyle(color: AppTheme.churchDarkText)), // Updated for better contrast on light card
      ],
    );
  }
}

class _DashboardButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _DashboardButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.surfaceColor, // Updated to white (or a very light theme color)
      elevation: 2, // Added some elevation
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: AppTheme.churchGold), // Updated icon color
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  color: AppTheme.churchDarkText, // Updated text color
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
