import 'package:flutter/material.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';

class ParentsScreen extends StatelessWidget {
  const ParentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy parents data
    final parents = [
      {
        'name': 'Fr. Antonios',
        'church': 'St. Mark Church',
        'phone': '01012345678',
        'region': 'Cairo',
      },
      {
        'name': 'Fr.ghopreal',
        'church': 'St. George Church',
        'phone': '01198765432',
        'region': 'El-minya',
      },
      {
        'name': 'Fr. Youhanna',
        'church': 'St. Mary Church',
        'phone': '01234567890',
        'region': 'Assiut',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Parents')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: parents.length,
        itemBuilder: (context, i) {
          final p = parents[i];
          return Card(
            color: AppTheme.secondaryColor.withOpacity(0.1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.person, color: AppTheme.primaryColor),
              title: Text(
                p['name']!,
                style: const TextStyle(color: AppTheme.primaryTextColor),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Church: ${p['church']}',
                    style: const TextStyle(color: AppTheme.primaryTextColor),
                  ),
                  Text(
                    'Phone: ${p['phone']}',
                    style: const TextStyle(color: AppTheme.primaryTextColor),
                  ),
                  Text(
                    'Region: ${p['region']}',
                    style: const TextStyle(color: AppTheme.primaryTextColor),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.phone, color: AppTheme.primaryColor),
                onPressed: () {},
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.secondaryColor,
        onPressed: () {},
        child: const Icon(Icons.add, color: AppTheme.primaryColor),
      ),
    );
  }
}
