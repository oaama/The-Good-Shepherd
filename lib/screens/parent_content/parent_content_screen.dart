import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';

class ParentContentScreen extends StatelessWidget {
  const ParentContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    const Map<String, String> dailyVerse = {
      'reference': 'Psalm 23:1',
      'text': 'The Lord is my shepherd, I lack nothing.',
    };
    
    const String dailyAdvice = 'Pray with a sincere heart today.';
    
    final List<Map<String, String>> sermons = [
      {'title': 'Faith Over Fear', 'desc': 'Trusting God in hard times.'},
      {'title': 'Love One Another', 'desc': 'The power of Christian love.'},
    ];
    
    final List<String> notices = ['Church meeting at 7pm.', 'Youth retreat next Friday.'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Priest Content'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            'Daily Verse',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: AppTheme.secondaryColor.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: const Icon(Icons.menu_book, color: AppTheme.primaryColor),
              title: Text(
                dailyVerse['reference']!,
                style: const TextStyle(
                  color: AppTheme.primaryTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                dailyVerse['text']!,
                style: const TextStyle(color: AppTheme.primaryTextColor),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Daily Advice',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: AppTheme.secondaryColor.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.tips_and_updates,
                color: AppTheme.primaryColor,
              ),
              title: Text(
                dailyAdvice,
                style: const TextStyle(color: AppTheme.primaryTextColor),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Sermons',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...sermons.map(
            (s) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              color: AppTheme.secondaryColor.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.play_circle_fill,
                  color: AppTheme.primaryColor,
                  size: 32,
                ),
                title: Text(
                  s['title']!,
                  style: const TextStyle(
                    color: AppTheme.primaryTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                subtitle: Text(
                  s['desc']!,
                  style: const TextStyle(color: AppTheme.primaryTextColor),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.play_arrow,
                    color: AppTheme.secondaryColor,
                    size: 32,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ).toList(),
          const SizedBox(height: 16),
          Text(
            'Notices',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ...notices.map(
            (n) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              color: AppTheme.secondaryColor.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.notifications,
                  color: AppTheme.primaryColor,
                ),
                title: Text(
                  n,
                  style: const TextStyle(color: AppTheme.primaryTextColor),
                ),
              ),
            ),
          ).toList(),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.go('/sermon-library'),
            icon: const Icon(Icons.library_books),
            label: const Text('Go to Sermon Library'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 2,
            ),
          ),
        ],
      ),
    );
  }
}
