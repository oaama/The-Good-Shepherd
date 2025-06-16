import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Welcome Message
              _buildHeader(theme, context),
              const SizedBox(height: 24),

              // Quick Actions
              _buildQuickActions(theme, context),
              const SizedBox(height: 24),

              // Daily Verse Card
              _buildDailyVerseCard(theme, context),
              const SizedBox(height: 24),

              // Latest Sermons
              _buildSectionHeader('العظات الأخيرة', context),
              const SizedBox(height: 16),
              _buildSermonsList(theme, context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(theme, context),
    );
  }

  Widget _buildHeader(ThemeData theme, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'مرحباً بك',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'نتمنى لك يوماً مباركاً',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.hintColor,
          ),
        ),
      ],
    );
  }


  Widget _buildQuickActions(ThemeData theme, BuildContext context) {
    final actions = [
      {'icon': Icons.library_books, 'label': 'المكتبة'},
      {'icon': Icons.event_note, 'label': 'المواعيد'},
      {'icon': Icons.help_outline, 'label': 'المساعدة'},
      {'icon': Icons.history, 'label': 'السجل'},
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      childAspectRatio: 0.9,
      children: actions.map((action) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                action['icon'] as IconData?,
                color: theme.colorScheme.secondary,
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              action['label'] as String,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        );
      }).toList(),
    );
  }


  Widget _buildDailyVerseCard(ThemeData theme, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.primaryColor.withOpacity(0.9),
            AppTheme.primaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.format_quote, color: Colors.white, size: 28),
              const Spacer(),
              Text(
                'آية اليوم',
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'لأَنَّهُ هَكَذَا أَحَبَّ اللَّهُ الْعَالَمَ حَتَّى بَذَلَ ابْنَهُ الْوَحِيدَ، لِكَيْ لاَ يَهْلِكَ كُلُّ مَنْ يُؤْمِنُ بِهِ، بَلْ تَكُونُ لَهُ الْحَيَاةُ الأَبَدِيَّةُ.',
            style: GoogleFonts.cairo(
              color: Colors.white,
              fontSize: 16,
              height: 1.5,
            ),
            textAlign: TextAlign.right,
          ),
          const SizedBox(height: 8),
          Text(
            'يوحنا 3: 16',
            style: GoogleFonts.cairo(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'عرض الكل',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      ],
    );
  }


  Widget _buildSermonsList(ThemeData theme, BuildContext context) {
    final sermons = [
      {
        'title': 'محبة الله العظيمة',
        'preacher': 'القس سمير حنا',
        'date': 'منذ يومين',
        'duration': '45:22'
      },
      {
        'title': 'الرجاء في المسيح',
        'preacher': 'القس بطرس عطية',
        'date': 'منذ أسبوع',
        'duration': '38:15'
      },
    ];

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sermons.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final sermon = sermons[index];
        return Card(
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.play_circle_filled,
                color: theme.colorScheme.primary,
                size: 36,
              ),
            ),
            title: Text(
              sermon['title'] as String,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  sermon['preacher'] as String,
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(height: 2),
                Text(
                  '${sermon['date']} • ${sermon['duration']}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.hintColor,
                  ),
                ),
              ],
            ),
            trailing: Icon(
              Icons.more_vert,
              color: theme.hintColor,
            ),
            onTap: () {
              // Navigate to sermon details
            },
          ),
        );
      },
    );
  }

  Widget _buildBottomNavBar(ThemeData theme, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: theme.hintColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.cairo(fontSize: 10),
        unselectedLabelStyle: GoogleFonts.cairo(fontSize: 10),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home_filled),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            activeIcon: Icon(Icons.library_books),
            label: 'المكتبة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'المواعيد',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }
}
