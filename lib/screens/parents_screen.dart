import 'package:flutter/material.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';

class ParentsScreen extends StatelessWidget {
  const ParentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parents'),
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
                    Icon(Icons.family_restroom, size: 72, color: AppTheme.gold),
                    const SizedBox(height: 20),
                    Text(
                      'Parents Area',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: AppTheme.navyBlue,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Manage spiritual fathers here.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: AppTheme.navyBlue),
                    ),
                    const SizedBox(height: 24),
                    _ParentCard(
                      name: 'Fr. Antonios',
                      church: 'St. Mark Church',
                    ),
                    const SizedBox(height: 12),
                    _ParentCard(
                      name: 'Fr. Bishoy',
                      church: 'St. George Church',
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.gold,
                        foregroundColor: AppTheme.navyBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('Add Spiritual Father'),
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

class _ParentCard extends StatelessWidget {
  final String name;
  final String church;
  const _ParentCard({required this.name, required this.church});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.gold.withOpacity(0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.gold, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppTheme.navyBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            church,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppTheme.navyBlue),
          ),
        ],
      ),
    );
  }
}
